class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.references :clinic, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.integer :replenisch_at_quantity

      t.timestamps
    end
  end
end
