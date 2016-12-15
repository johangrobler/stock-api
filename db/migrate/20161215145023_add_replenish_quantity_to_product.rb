class AddReplenishQuantityToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :replenish_quantity, :integer
  end
end
