class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
    def show
      @order = Order.find(params[:id])
      # Stripe check et mise à jour de status si nécessaire
      if @order.status == 'pending' && @order.stripe_session_id.present?
        session = Stripe::Checkout::Session.retrieve(@order.stripe_session_id)
        if session.payment_status == 'paid'
          @order.update(status: 'paid')
        end
      end
    end


  # GET /orders/new
  def new
    @order = Order.new
    @cart = current_user.cart
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @cart = current_user.cart

    if @cart.cart_dishes.empty?
      redirect_to cart_path(@cart), alert: "Votre panier est vide. Ajoutez des articles avant de passer la commande."
      return
    end

    order_status = params[:pay_on_site].present? ? 'pending_payment' : 'pending'

    @order = current_user.orders.create!(total_price: @cart.total_price, status: order_status)

    # Copier aussi les ingrédients personnalisés depuis cart_dish.ingredients
    @cart.cart_dishes.each do |cart_dish|
      @order.order_dishes.create!(
        dish_id: cart_dish.dish_id,
        quantity: cart_dish.quantity,
        ingredients: cart_dish.ingredients # <-- copie ici les ingrédients personnalisés
      )
    end

    # Vider le panier après la création de la commande
    @cart.cart_dishes.destroy_all

    if params[:pay_on_site].present?
      redirect_to order_path(@order), notice: "Commande créée, vous pourrez la régler sur place."
    else
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: @order.order_dishes.map do |od|
          {
            price_data: {
              currency: 'eur',
              product_data: { name: od.dish.title },
              unit_amount: (od.dish.price * 100).to_i,
            },
            quantity: od.quantity,
          }
        end,
        mode: 'payment',
        success_url: order_url(@order),
        cancel_url: cart_url(@cart),
      })

      @order.update(stripe_session_id: session.id)

      redirect_to session.url, allow_other_host: true
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Commande mise à jour avec succès.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
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
end
