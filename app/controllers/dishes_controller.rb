class DishesController < ApplicationController
  before_action :set_dish, only: %i[show edit update destroy]
  before_action :check_admin, only: %i[new create edit update destroy]
  before_action :set_cart, only: [ :index ]  # Pour définir le panier sur l’index


  def index
    @dishes = Dish.all
  end


def show
  @dish = Dish.find(params[:id])

  if user_signed_in?
    @cart = current_user.cart || current_user.create_cart
  else
    @cart = nil
  end


  @ingredients = @dish.default_ingredients_list


  @sauces = Dish.available_sauces

  @menu_extra_price = 2.5
end


  def new
    @dish = Dish.new
  end


  def edit
  end


  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      redirect_to @dish, notice: "Dish was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    if @dish.update(dish_params)
      redirect_to @dish, notice: "Dish was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @dish.destroy!
    redirect_to dishes_path, notice: "Dish was successfully destroyed.", status: :see_other
  end

  private


  def set_dish
    @dish = Dish.find(params[:id])
  end


  def dish_params
    params.require(:dish).permit(:title, :description, :price, :image)
  end


  def check_admin
    unless current_user&.admin?
      redirect_to dishes_path, alert: "You are not authorized to perform this action."
    end
  end


  def set_cart
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      @cart = nil
    end
  end
end
