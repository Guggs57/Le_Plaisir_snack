class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[ show edit update destroy ]


  def index
    @ingredients = Ingredient.all
  end


  def show
  end


  def new
    @ingredient = Ingredient.new
  end


  def edit
  end


  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to @ingredient, notice: "Ingredient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient, notice: "Ingredient was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @ingredient.destroy!
    redirect_to ingredients_path, notice: "Ingredient was successfully destroyed.", status: :see_other
  end

  private

    def set_ingredient
      @ingredient = Ingredient.find(params.expect(:id))
    end


    def ingredient_params
      params.expect(ingredient: [ :name, :is_allergen ])
    end
end
