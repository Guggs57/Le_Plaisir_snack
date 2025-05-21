class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy 
  after_create :welcome_send
  has_many :orders, dependent: :destroy
  after_create :initialize_cart
  after_create :create_cart

  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  private
  
  def initialize_cart
    Cart.create(user: self)
  end
end


