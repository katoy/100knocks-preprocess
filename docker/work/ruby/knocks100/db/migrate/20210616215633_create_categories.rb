class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories, id: false do |t|
      t.string :category_major_cd, null: false
      t.string :category_major_name, null: false
      t.string :category_medium_cd, null: false
      t.string :category_medium_name, null: false
      t.string :category_small_cd, null: false, primary_key: true
      t.string :category_small_name, null: false
    end

    add_index :categories, [:category_major_cd], name: :categories_majaor_index
    add_index :categories, [:category_medium_cd], name: :categories_medium_index
    add_index :categories, [:category_small_cd], unique: true, name: :categories_small_index
  end
end
