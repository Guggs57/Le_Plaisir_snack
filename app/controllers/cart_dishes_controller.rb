class CartDishesController < ApplicationController
  before_action :set_cart_dish, only: %i[show edit update destroy update_quantity]

  # GET /cart_dishes
  def index
    @cart_dishes = CartDish.all
  end

  # GET /cart_dishes/1
  def show
  end

  # GET /cart_dishes/new
  def new
    @cart_dish = CartDish.new
  end

  # GET /cart_dishes/1/edit
  def edit
  end

  # POST /cart_dishes
  def create
    @cart_dish = CartDish.new(cart_dish_params)

    if @cart_dish.save
      redirect_to @cart_dish, notice: "Cart dish was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cart_dishes/1
  def update
    if @cart_dish.update(cart_dish_params)
      redirect_to @cart_dish, notice: "Cart dish was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # PATCH /cart_dishes/1/update_quantity
  def update_quantity
    if @cart_dish.update(quantity: params[:quantity])
      redirect_to cart_path(current_user.cart), notice: "Quantité mise à jour."
    else
      redirect_to cart_path(current_user.cart), alert: "Erreur lors de la mise à jour."
    end
  end

  # DELETE /cart_dishes/1
  def destroy
    @cart_dish.destroy!
    redirect_to cart_path(current_user.cart), notice: "Plat supprimé du panier.", status: :see_other
  end

  private

  def set_cart_dish
    @cart_dish = CartDish.find(params[:id])
  end

  def cart_dish_params
    params.require(:cart_dish).permit(:cart_id, :dish_id, :quantity)
  end
end
