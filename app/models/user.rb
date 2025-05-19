class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :cart, dependent: :destroy

  after_create :initialize_cart
  has_many :orders, dependent: :destroy

  def initialize_cart
    Cart.create(user: self)
  end
end
