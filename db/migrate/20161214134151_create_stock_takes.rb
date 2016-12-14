class CreateStockTakes < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_takes do |t|
      t.references :product, foreign_key: true
      t.references :clinic, foreign_key: true
      t.float :latitude
      t.string :longitude
      t.integer :quantity

      t.timestamps
    end
  end
end
