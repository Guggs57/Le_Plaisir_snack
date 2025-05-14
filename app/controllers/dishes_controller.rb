class DishesController < ApplicationController
  before_action :set_dish, only: %i[show edit update destroy]
  before_action :check_admin, only: %i[edit update destroy]  # Ajout de la vérification admin
  before_action :set_cart, only: [:index]  # Ajouter cette ligne pour définir le panier

  # GET /dishes
  def index
    @dishes = Dish.all
  end

  # GET /dishes/1
  def show
    @dish = Dish.find(params[:id])
    @cart = current_user.cart || current_user.create_cart
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

  # Use callbacks to share common setup or constraints between actions.
  def set_dish
    @dish = Dish.find(params[:id])  # Utilisation de `params[:id]` au lieu de `params.expect(:id)`
  end

  # Only allow a list of trusted parameters through.
  def dish_params
    params.require(:dish).permit(:title, :description, :price, :image_url)  # Utilisation de `require` et `permit`
  end

  # Vérification si l'utilisateur est un administrateur
  def check_admin
    unless current_user&.admin?
      redirect_to dishes_path, alert: "You are not authorized to perform this action."  # Redirige si non-admin
    end
  end

  # Méthode pour récupérer ou créer le panier de l'utilisateur
  def set_cart
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      @cart = nil
    end
  end

end
