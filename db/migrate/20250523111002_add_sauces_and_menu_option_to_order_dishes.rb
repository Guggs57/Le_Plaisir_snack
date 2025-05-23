class AddSaucesAndMenuOptionToOrderDishes < ActiveRecord::Migration[8.0]
  def change
    add_column :order_dishes, :sauces, :string
    add_column :order_dishes, :menu_option, :boolean
  end
end
