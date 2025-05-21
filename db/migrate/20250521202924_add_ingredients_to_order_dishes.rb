class AddIngredientsToOrderDishes < ActiveRecord::Migration[8.0]
  def change
    add_column :order_dishes, :ingredients, :json, default: []
  end
end
