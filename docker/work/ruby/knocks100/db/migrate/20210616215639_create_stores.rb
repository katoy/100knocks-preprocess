class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores, id: false do |t|
      t.string :store_cd, null: false, primary_key: true
      t.string :store_name
      t.string :prefecture_cd, index: true
      t.string :prefecture
      t.string :address
      t.string :address_kana
      t.string :tel_no
      t.decimal :longitude, precision: 11, scale: 8
      t.decimal :latitude, precision: 11, scale: 8
      t.string :floor_area
    end
  end
end
