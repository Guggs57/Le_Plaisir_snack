class CartDishesController < ApplicationController
  before_action :set_cart_dish, only: %i[show edit update destroy update_quantity]

  def index
    @cart_dishes = CartDish.all
  end

  def show
    @cart = @cart_dish.cart
    @dish = @cart_dish.dish
  end

  def new
    @cart_dish = CartDish.new
  end

  def edit
    # @cart_dish est déjà chargé par set_cart_dish
  end

  def create
    @cart_dish = CartDish.new(cart_dish_params)

    if @cart_dish.save
      redirect_to @cart_dish, notice: "Plat ajouté au panier avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    # Important : forcer tableau vide si aucun ingrédient ou sauce sélectionné
    params[:cart_dish][:ingredients] ||= []
    params[:cart_dish][:sauces] ||= []

    if @cart_dish.update(cart_dish_params)
      redirect_to cart_path(@cart_dish.cart), notice: 'Modification enregistrée avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_quantity
    if @cart_dish.update(quantity: params[:quantity])
      redirect_to cart_path(current_user.cart), notice: "Quantité mise à jour."
    else
      redirect_to cart_path(current_user.cart), alert: "Erreur lors de la mise à jour."
    end
  end

  def destroy
    @cart_dish.destroy!
    redirect_to cart_path(current_user.cart), notice: "Plat supprimé du panier.", status: :see_other
  end

  private

  def set_cart_dish
    @cart_dish = CartDish.find(params[:id])
  end

  def cart_dish_params
    params.require(:cart_dish).permit(:quantity, ingredients: [], sauces: [])
  end
end
