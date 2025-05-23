class CartDish < ApplicationRecord
  belongs_to :cart
  belongs_to :dish

  SOME_MENU_EXTRA_PRICE = 2.5

  # Par défaut, menu_option est false
  attribute :menu_option, :boolean, default: false

  def ingredients_objects
    Ingredient.where(id: ingredients)
  end

  def unit_price
    dish.price + (menu_option ? SOME_MENU_EXTRA_PRICE : 0)
  end

  def total_price
    quantity * unit_price
  end
end
