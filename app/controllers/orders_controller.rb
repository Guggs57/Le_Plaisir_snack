class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    # Vérifier si la commande a déjà été payée
    if @order.status == 'pending' && @order.stripe_session_id.present?
      session = Stripe::Checkout::Session.retrieve(@order.stripe_session_id)

      # Si le paiement est réussi, mettez à jour l'état de la commande
      if session.payment_status == 'paid'
        @order.update(status: 'paid')
      end
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @cart = current_user.cart

    # Vérifier si le panier est vide
    if @cart.cart_dishes.empty?
      redirect_to cart_path(@cart), alert: "Votre panier est vide. Ajoutez des articles avant de passer la commande."
      return
    end

    # Créer une nouvelle commande avec le prix total du panier
    @order = current_user.orders.create!(total_price: @cart.total_price, status: 'pending')

    # Ajouter les plats du panier à la commande
    @cart.cart_dishes.each do |cart_dish|
      @order.order_dishes.create!(dish_id: cart_dish.dish_id, quantity: cart_dish.quantity)
    end

    # Vider le panier après la création de la commande
    @cart.cart_dishes.destroy_all

    # Créer une session de paiement Stripe
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: @order.order_dishes.map do |od|
        {
          price_data: {
            currency: 'usd',  # Ou 'eur' si tu préfères
            product_data: {
              name: od.dish.title,  # Utilise `od.dish` pour accéder au plat
            },
            unit_amount: (od.dish.price * 100).to_i,  # Stripe attend le montant en cents
          },
          quantity: od.quantity,
        }
      end,
      mode: 'payment',
      success_url: order_url(@order), # Rediriger l'utilisateur après paiement réussi
      cancel_url: cart_url(@cart),    # Rediriger l'utilisateur en cas d'annulation
    })

    # Mettez à jour la session Stripe ID dans la commande
    @order.update(stripe_session_id: session.id)

    # Rediriger l'utilisateur vers Stripe pour le paiement
    redirect_to session.url, allow_other_host: true
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Order was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy!
    redirect_to orders_path, notice: "Order was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:user_id, :total_price, :status)
  end
end
