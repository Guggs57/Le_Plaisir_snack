class Dish < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image_url, presence: true  # Correction ici, il manquait la parenthèse fermante

  # Relations
  has_many :order_dishes
  has_many :orders, through: :order_dishes
  has_one_attached :image
  has_many :dish_ingredients, dependent: :destroy
  has_many :ingredients, through: :dish_ingredients

def ingredients
    [
      "salade",
      "tomate",
      "oignons",
      "choux blanc",
      "choux rouge",
      "piment vert",
      "piment rouge",
      "concombre"
    ]
  end

end

  