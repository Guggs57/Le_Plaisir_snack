class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_dishes
  has_many :dishes, through: :cart_dishes
end
