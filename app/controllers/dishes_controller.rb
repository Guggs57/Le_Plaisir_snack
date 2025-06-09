class DishesController < ApplicationController
  before_action :set_dish, only: %i[show edit update destroy]
  before_action :check_admin, only: %i[new create edit update destroy]
  before_action :set_cart, only: [ :index ]  # Pour définir le panier sur l’index

  # GET /dishes
  def index
    @dishes = Dish.all
  end

# GET /dishes/1
def show
  @dish = Dish.find(params[:id])

  if user_signed_in?
    @cart = current_user.cart || current_user.create_cart
  else
    @cart = nil
  end

  # Liste d'ingrédients statique (à retirer) :
  @ingredients = @dish.default_ingredients_list

  # Sauces statiques :
  @sauces = Dish.available_sauces

  @menu_extra_price = 2.5
end

  # GET /dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
  end

  # POST /dishes
  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      redirect_to @dish, notice: "Dish was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dishes/1
  def update
    if @dish.update(dish_params)
      redirect_to @dish, notice: "Dish was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dishes/1
  def destroy
    @dish.destroy!
    redirect_to dishes_path, notice: "Dish was successfully destroyed.", status: :see_other
  end

  private

  # Récupérer le plat via l’ID
  def set_dish
    @dish = Dish.find(params[:id])
  end

  # Autoriser les paramètres
  def dish_params
    params.require(:dish).permit(:title, :description, :price, :image)
  end

  # Empêcher les non-admins d'accéder à certaines actions
  def check_admin
    unless current_user&.admin?
      redirect_to dishes_path, alert: "You are not authorized to perform this action."
    end
  end

  # Définir le panier (utilisé pour l'index)
  def set_cart
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      @cart = nil
    end
  end
end
