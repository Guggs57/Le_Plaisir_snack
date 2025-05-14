class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def total_price
    order_dishes.sum { |od| od.unit_price * od.quantity }
  end

    def checkout
    @order = current_user.orders.find(params[:id])

    # Créer une session de paiement Stripe
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: @order.order_dishes.map do |order_dish|
        {
          price_data: {
            currency: 'eur',
            unit_amount: (order_dish.dish.price * 100).to_i, # Convertir en centimes
            product_data: {
              name: order_dish.dish.title,
              description: order_dish.dish.description
            }
          },
          quantity: order_dish.quantity
        }
      end,
      mode: 'payment',
      success_url: order_url(@order),  # Remplace avec l'URL de succès
      cancel_url: cart_url            # Remplace avec l'URL de retour en cas d'annulation
    )

    # Enregistrer l'ID de session Stripe dans la commande
    @order.update(stripe_session_id: session.id)

    # Rediriger l'utilisateur vers Stripe
    redirect_to session.url, allow_other_host: true
  end



  # POST /orders
  def create
    # Récupérer le panier de l'utilisateur connecté
    @cart = current_user.cart

    # Créer une nouvelle commande avec le prix total du panier
    @order = current_user.orders.create!(total_price: @cart.total_price, status: 'pending')

    # Ajouter les plats du panier à la commande
    @cart.cart_dishes.each do |cart_dish|
      @order.order_dishes.create!(
        dish: cart_dish.dish,
        quantity: cart_dish.quantity
      )
    end

    # Vider le panier
    @cart.cart_dishes.destroy_all

    # Rediriger l'utilisateur vers la page de la commande
    redirect_to @order, notice: 'Votre commande a été passée avec succès.'
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
      @order = Order.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.expect(order: [ :user_id, :total_price, :status ])
    end
end
