class CartDish < ApplicationRecord
  belongs_to :cart
  belongs_to :dish

    def total_price 
        quantity * dish.price 
    end
end
