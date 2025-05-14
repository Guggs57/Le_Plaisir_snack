class OrderDishesController < ApplicationController
  before_action :set_order_dish, only: %i[ show edit update destroy ]

  # GET /order_dishes
  def index
    @order_dishes = OrderDish.all
  end

  # GET /order_dishes/1
  def show
  end

  # GET /order_dishes/new
  def new
    @order_dish = OrderDish.new
  end

  # GET /order_dishes/1/edit
  def edit
  end

  # POST /order_dishes
  def create
    @order_dish = OrderDish.new(order_dish_params)

    if @order_dish.save
      redirect_to @order_dish, notice: "Order dish was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_dishes/1
  def update
    if @order_dish.update(order_dish_params)
      redirect_to @order_dish, notice: "Order dish was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /order_dishes/1
  def destroy
    @order_dish.destroy!
    redirect_to order_dishes_path, notice: "Order dish was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_dish
      @order_dish = OrderDish.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def order_dish_params
      params.expect(order_dish: [ :order_id, :dish_id, :quantity ])
    end
end
