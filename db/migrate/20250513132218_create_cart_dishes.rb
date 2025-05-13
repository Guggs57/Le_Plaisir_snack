class CreateCartDishes < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_dishes do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :dish, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
