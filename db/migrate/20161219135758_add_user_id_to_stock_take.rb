class AddUserIdToStockTake < ActiveRecord::Migration[5.0]
  def change
    add_column :stock_takes, :user_id, :integer
    add_index :stock_takes, :user_id
  end
end
