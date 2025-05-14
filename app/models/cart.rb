class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_dishes, dependent: :destroy
  has_many :dishes, through: :cart_dishes

    def total_price
    cart_dishes.sum { |cart_dish| cart_dish.dish.price * cart_dish.quantity }
  end

  
end
