class CartDish < ApplicationRecord
  belongs_to :cart
  belongs_to :dish

  # Pas besoin de serialize pour json/jsonb natif

  def ingredients_objects
    Ingredient.where(id: ingredients)
  end

  def total_price
    quantity * dish.price
  end
end
