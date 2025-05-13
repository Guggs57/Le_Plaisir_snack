require "test_helper"

class CartDishesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart_dish = cart_dishes(:one)
  end

  test "should get index" do
    get cart_dishes_url
    assert_response :success
  end

  test "should get new" do
    get new_cart_dish_url
    assert_response :success
  end

  test "should create cart_dish" do
    assert_difference("CartDish.count") do
      post cart_dishes_url, params: { cart_dish: { cart_id: @cart_dish.cart_id, dish_id: @cart_dish.dish_id, quantity: @cart_dish.quantity } }
    end

    assert_redirected_to cart_dish_url(CartDish.last)
  end

  test "should show cart_dish" do
    get cart_dish_url(@cart_dish)
    assert_response :success
  end

  test "should get edit" do
    get edit_cart_dish_url(@cart_dish)
    assert_response :success
  end

  test "should update cart_dish" do
    patch cart_dish_url(@cart_dish), params: { cart_dish: { cart_id: @cart_dish.cart_id, dish_id: @cart_dish.dish_id, quantity: @cart_dish.quantity } }
    assert_redirected_to cart_dish_url(@cart_dish)
  end

  test "should destroy cart_dish" do
    assert_difference("CartDish.count", -1) do
      delete cart_dish_url(@cart_dish)
    end

    assert_redirected_to cart_dishes_url
  end
end
