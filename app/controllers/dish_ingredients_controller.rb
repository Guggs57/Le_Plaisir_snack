class DishIngredientsController < ApplicationController
  before_action :set_dish_ingredient, only: %i[ show edit update destroy ]


  def index
    @dish_ingredients = DishIngredient.all
  end


  def show
  end


  def new
    @dish_ingredient = DishIngredient.new
  end


  def edit
  end


  def create
    @dish_ingredient = DishIngredient.new(dish_ingredient_params)

    if @dish_ingredient.save
      redirect_to @dish_ingredient, notice: "Dish ingredient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    if @dish_ingredient.update(dish_ingredient_params)
      redirect_to @dish_ingredient, notice: "Dish ingredient was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @dish_ingredient.destroy!
    redirect_to dish_ingredients_path, notice: "Dish ingredient was successfully destroyed.", status: :see_other
  end

  private

    def set_dish_ingredient
      @dish_ingredient = DishIngredient.find(params.expect(:id))
    end


    def dish_ingredient_params
      params.expect(dish_ingredient: [ :dish_id, :ingredient_id ])
    end
end
