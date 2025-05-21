class ChangeIngredientsAndSaucesTypeInCartDishes < ActiveRecord::Migration[7.0]
  def change
    change_column :cart_dishes, :ingredients, :json, default: [], using: 'ingredients::json'
    change_column :cart_dishes, :sauces, :json, default: [], using: 'sauces::json'
  end
end
