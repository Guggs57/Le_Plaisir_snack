class DishIngredientsController < ApplicationController
  before_action :set_dish_ingredient, only: %i[ show edit update destroy ]

  # GET /dish_ingredients
  def index
    @dish_ingredients = DishIngredient.all
  end

  # GET /dish_ingredients/1
  def show
  end

  # GET /dish_ingredients/new
  def new
    @dish_ingredient = DishIngredient.new
  end

  # GET /dish_ingredients/1/edit
  def edit
  end

  # POST /dish_ingredients
  def create
    @dish_ingredient = DishIngredient.new(dish_ingredient_params)

    if @dish_ingredient.save
      redirect_to @dish_ingredient, notice: "Dish ingredient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dish_ingredients/1
  def update
    if @dish_ingredient.update(dish_ingredient_params)
      redirect_to @dish_ingredient, notice: "Dish ingredient was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dish_ingredients/1
  def destroy
    @dish_ingredient.destroy!
    redirect_to dish_ingredients_path, notice: "Dish ingredient was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish_ingredient
      @dish_ingredient = DishIngredient.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def dish_ingredient_params
      params.expect(dish_ingredient: [ :dish_id, :ingredient_id ])
    end
end
