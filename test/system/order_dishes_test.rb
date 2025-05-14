require "application_system_test_case"

class OrderDishesTest < ApplicationSystemTestCase
  setup do
    @order_dish = order_dishes(:one)
  end

  test "visiting the index" do
    visit order_dishes_url
    assert_selector "h1", text: "Order dishes"
  end

  test "should create order dish" do
    visit order_dishes_url
    click_on "New order dish"

    fill_in "Dish", with: @order_dish.dish_id
    fill_in "Order", with: @order_dish.order_id
    fill_in "Quantity", with: @order_dish.quantity
    click_on "Create Order dish"

    assert_text "Order dish was successfully created"
    click_on "Back"
  end

  test "should update Order dish" do
    visit order_dish_url(@order_dish)
    click_on "Edit this order dish", match: :first

    fill_in "Dish", with: @order_dish.dish_id
    fill_in "Order", with: @order_dish.order_id
    fill_in "Quantity", with: @order_dish.quantity
    click_on "Update Order dish"

    assert_text "Order dish was successfully updated"
    click_on "Back"
  end

  test "should destroy Order dish" do
    visit order_dish_url(@order_dish)
    accept_confirm { click_on "Destroy this order dish", match: :first }

    assert_text "Order dish was successfully destroyed"
  end
end
