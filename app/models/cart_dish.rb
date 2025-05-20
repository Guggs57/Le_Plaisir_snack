class CartDish < ApplicationRecord
  belongs_to :cart
  belongs_to :dish

  store :ingredients, accessors: [], coder: JSON
  store :sauces, accessors: [], coder: JSON


  def total_price
    quantity * dish.price
  end
end