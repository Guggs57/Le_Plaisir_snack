class Dish < ApplicationRecord
  validates :title, presence: true
  # validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :image_url, presence: true

  # Relations
  has_many :order_dishes
  has_many :orders, through: :order_dishes
  has_one_attached :image
  has_many :dish_ingredients, dependent: :destroy
  has_many :ingredients, through: :dish_ingredients

  # Liste statique des ingrédients par défaut
  def default_ingredients_list
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

  # Version affichable pour RailsAdmin ou les vues
  def default_ingredients
    default_ingredients_list.join(", ")
  end

  # Liste des sauces disponibles
  def self.available_sauces
    [
      "curry",
      "ketchup curry",
      "mayonnaise",
      "ketchup",
      "algérienne",
      "marocaine",
      "andalouse",
      "sauce blanche",
      "samouraï",
      "harissa",
      "fromagère"
    ]
  end
end
