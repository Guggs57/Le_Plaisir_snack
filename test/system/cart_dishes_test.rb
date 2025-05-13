require "application_system_test_case"

class CartDishesTest < ApplicationSystemTestCase
  setup do
    @cart_dish = cart_dishes(:one)
  end

  test "visiting the index" do
    visit cart_dishes_url
    assert_selector "h1", text: "Cart dishes"
  end

  test "should create cart dish" do
    visit cart_dishes_url
    click_on "New cart dish"

    fill_in "Cart", with: @cart_dish.cart_id
    fill_in "Dish", with: @cart_dish.dish_id
    fill_in "Quantity", with: @cart_dish.quantity
    click_on "Create Cart dish"

    assert_text "Cart dish was successfully created"
    click_on "Back"
  end

  test "should update Cart dish" do
    visit cart_dish_url(@cart_dish)
    click_on "Edit this cart dish", match: :first

    fill_in "Cart", with: @cart_dish.cart_id
    fill_in "Dish", with: @cart_dish.dish_id
    fill_in "Quantity", with: @cart_dish.quantity
    click_on "Update Cart dish"

    assert_text "Cart dish was successfully updated"
    click_on "Back"
  end

  test "should destroy Cart dish" do
    visit cart_dish_url(@cart_dish)
    accept_confirm { click_on "Destroy this cart dish", match: :first }

    assert_text "Cart dish was successfully destroyed"
  end
end
