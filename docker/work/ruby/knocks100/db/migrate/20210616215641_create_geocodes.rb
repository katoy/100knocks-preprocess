class CreateGeocodes < ActiveRecord::Migration[6.1]
  def change
    create_table :geocodes do |t|
      t.string :postal_cd
      t.string :prefecture
      t.string :city
      t.string :town
      t.string :street
      t.string :address
      t.string :full_address, null: false, index: true
      t.decimal :longitude, precision: 11, scale: 8, null: false
      t.decimal :latitude, precision: 11, scale: 8, null: false
    end
  end
end
