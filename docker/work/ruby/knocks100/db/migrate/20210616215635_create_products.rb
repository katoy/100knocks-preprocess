class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, id: false do |t|
      t.string :product_cd, null: false, primary_key: true
      t.string :category_major_cd
      t.string :category_medium_cd
      t.string :category_small_cd, index: true
      t.float :unit_price
      t.float :unit_cost
      # t.string :category_major_name
      # t.string :category_medium_name
      # t.string :category_small_name
    end
  end
end
