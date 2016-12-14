class CreateClinics < ActiveRecord::Migration[5.0]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :mobile

      t.timestamps
    end
  end
end
