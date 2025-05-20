class AddIngredientsAndSaucesToCartDishes < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_dishes, :ingredients, :text
    add_column :cart_dishes, :sauces, :text
  end
end
