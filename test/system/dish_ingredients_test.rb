require "application_system_test_case"

class DishIngredientsTest < ApplicationSystemTestCase
  setup do
    @dish_ingredient = dish_ingredients(:one)
  end

  test "visiting the index" do
    visit dish_ingredients_url
    assert_selector "h1", text: "Dish ingredients"
  end

  test "should create dish ingredient" do
    visit dish_ingredients_url
    click_on "New dish ingredient"

    fill_in "Dish", with: @dish_ingredient.dish_id
    fill_in "Ingredient", with: @dish_ingredient.ingredient_id
    click_on "Create Dish ingredient"

    assert_text "Dish ingredient was successfully created"
    click_on "Back"
  end

  test "should update Dish ingredient" do
    visit dish_ingredient_url(@dish_ingredient)
    click_on "Edit this dish ingredient", match: :first

    fill_in "Dish", with: @dish_ingredient.dish_id
    fill_in "Ingredient", with: @dish_ingredient.ingredient_id
    click_on "Update Dish ingredient"

    assert_text "Dish ingredient was successfully updated"
    click_on "Back"
  end

  test "should destroy Dish ingredient" do
    visit dish_ingredient_url(@dish_ingredient)
    accept_confirm { click_on "Destroy this dish ingredient", match: :first }

    assert_text "Dish ingredient was successfully destroyed"
  end
end
