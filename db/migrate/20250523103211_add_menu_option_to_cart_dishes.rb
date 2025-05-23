class AddMenuOptionToCartDishes < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_dishes, :menu_option, :boolean, default: false, null: false
  end
end
