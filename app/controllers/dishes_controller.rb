class DishesController < ApplicationController
  before_action :set_dish, only: %i[ show edit update destroy ]

  # GET /dishes
  def index
    @dishes = Dish.all
  end

  # GET /dishes/1
  def show
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
      @dish = Dish.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def dish_params
      params.expect(dish: [ :title, :description, :price, :image_url ])
    end
end
