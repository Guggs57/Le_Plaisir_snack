class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]

  # GET /carts
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  def show
    @cart = current_user.cart
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to @cart, notice: "Cart was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: "Cart was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    @cart.destroy!
    redirect_to carts_path, notice: "Cart was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
     if params[:id].present?
    @cart = Cart.find_by(id: params[:id])
    unless @cart
      flash[:alert] = "Le panier n'a pas été trouvé."
      redirect_to root_path # Redirige vers la page d'accueil ou une autre page en cas d'erreur
    end
  else
    flash[:alert] = "L'ID du panier est manquant."
    redirect_to root_path # Redirige vers la page d'accueil ou une autre page en cas d'erreur
  end
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.expect(cart: [ :user_id ])
    end
end
