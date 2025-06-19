class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]


  def index
    @orders = Order.all
  end


  def show
    @order = Order.find(params[:id])

    if @order.status == "pending" && @order.stripe_session_id.present?
      session = Stripe::Checkout::Session.retrieve(@order.stripe_session_id)
      if session.payment_status == "paid"
        @order.update(status: "paid")
      end
    end
  end


  def new
    @order = Order.new
    @cart = current_user.cart
  end


  def create
    @cart = current_user.cart

    if @cart.cart_dishes.empty?
      redirect_to cart_path(@cart), alert: "Votre panier est vide. Ajoutez des articles avant de passer la commande."
      return
    end

    order_status = params[:pay_on_site].present? ? "pending_payment" : "pending"


    total_price = @cart.cart_dishes.sum(&:total_price)

    @order = current_user.orders.create!(
      total_price: total_price,
      status: order_status
    )


    @cart.cart_dishes.each do |cart_dish|
      @order.order_dishes.create!(
        dish_id: cart_dish.dish_id,
        quantity: cart_dish.quantity,
        ingredients: cart_dish.ingredients,
        sauces: cart_dish.sauces,
        menu_option: cart_dish.menu_option
      )
    end


    @cart.cart_dishes.destroy_all

    if params[:pay_on_site].present?
      redirect_to order_path(@order), notice: "Commande créée, vous pourrez la régler sur place."
    else
      session = Stripe::Checkout::Session.create({
        payment_method_types: [ "card" ],
        line_items: @order.order_dishes.map do |od|
          {
            price_data: {
              currency: "eur",
              product_data: {
                name: od.menu_option ? "MENU - #{od.dish.title}" : od.dish.title
              },
              unit_amount: (unit_price_order_dish(od) * 100).to_i
            },
            quantity: od.quantity
          }
        end,
        mode: "payment",
        success_url: order_url(@order),
        cancel_url: cart_url(@cart)
      })

      @order.update(stripe_session_id: session.id)

      redirect_to session.url, allow_other_host: true
    end
  end


  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Commande mise à jour avec succès.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @order.destroy!
    redirect_to orders_path, notice: "Commande supprimée.", status: :see_other
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :total_price, :status)
  end


  def unit_price_order_dish(order_dish)
    base_price = order_dish.dish.price
    menu_extra = order_dish.menu_option ? CartDish::SOME_MENU_EXTRA_PRICE : 0
    base_price + menu_extra
  end
end
