require "test_helper"

class OrderDishesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_dish = order_dishes(:one)
  end

  test "should get index" do
    get order_dishes_url
    assert_response :success
  end

  test "should get new" do
    get new_order_dish_url
    assert_response :success
  end

  test "should create order_dish" do
    assert_difference("OrderDish.count") do
      post order_dishes_url, params: { order_dish: { dish_id: @order_dish.dish_id, order_id: @order_dish.order_id, quantity: @order_dish.quantity } }
    end

    assert_redirected_to order_dish_url(OrderDish.last)
  end

  test "should show order_dish" do
    get order_dish_url(@order_dish)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_dish_url(@order_dish)
    assert_response :success
  end

  test "should update order_dish" do
    patch order_dish_url(@order_dish), params: { order_dish: { dish_id: @order_dish.dish_id, order_id: @order_dish.order_id, quantity: @order_dish.quantity } }
    assert_redirected_to order_dish_url(@order_dish)
  end

  test "should destroy order_dish" do
    assert_difference("OrderDish.count", -1) do
      delete order_dish_url(@order_dish)
    end

    assert_redirected_to order_dishes_url
  end
end
