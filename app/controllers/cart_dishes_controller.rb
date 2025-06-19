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
  end

  def create
    @cart_dish = CartDish.new(cart_dish_params)
    @cart_dish.cart = current_user.cart || current_user.create_cart
    @cart_dish.quantity ||= 1


    @cart_dish.ingredients ||= []
    @cart_dish.sauces ||= []

    if @cart_dish.save
      redirect_to cart_path(@cart_dish.cart), notice: "Plat ajouté au panier avec succès."
    else
      flash.now[:alert] = "Erreur lors de l'ajout au panier."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    params[:cart_dish][:ingredients] ||= []
    params[:cart_dish][:sauces] ||= []

    if @cart_dish.update(cart_dish_params)
      redirect_to cart_path(@cart_dish.cart), notice: "Modification enregistrée avec succès."
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
    params.require(:cart_dish).permit(:dish_id, :quantity, :menu_option, ingredients: [], sauces: [])
  end
end
