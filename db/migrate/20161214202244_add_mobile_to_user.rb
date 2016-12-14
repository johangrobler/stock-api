class AddMobileToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :mobile, :string
    add_column :users, :pin, :string
  end
end
