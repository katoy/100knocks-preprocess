# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_16_215848) do

  create_table "categories", primary_key: "category_small_cd", id: :string, force: :cascade do |t|
    t.string "category_major_cd", null: false
    t.string "category_major_name", null: false
    t.string "category_medium_cd", null: false
    t.string "category_medium_name", null: false
    t.string "category_small_name", null: false
    t.index ["category_major_cd"], name: "categories_majaor_index"
    t.index ["category_medium_cd"], name: "categories_medium_index"
    t.index ["category_small_cd"], name: "categories_small_index", unique: true
  end

  create_table "customers", primary_key: "customer_id", id: :string, force: :cascade do |t|
    t.string "customer_name"
    t.string "gender_cd"
    t.string "gender"
    t.date "birth_day"
    t.integer "age"
    t.string "postal_cd"
    t.string "address"
    t.string "application_store_cd"
    t.date "application_date"
    t.string "status_cd"
  end

  create_table "geocodes", force: :cascade do |t|
    t.string "postal_cd"
    t.string "prefecture"
    t.string "city"
    t.string "town"
    t.string "street"
    t.string "address"
    t.string "full_address", null: false
    t.decimal "longitude", precision: 11, scale: 8, null: false
    t.decimal "latitude", precision: 11, scale: 8, null: false
    t.index ["full_address"], name: "index_geocodes_on_full_address"
  end

  create_table "products", primary_key: "product_cd", id: :string, force: :cascade do |t|
    t.string "category_major_cd"
    t.string "category_medium_cd"
    t.string "category_small_cd"
    t.float "unit_price"
    t.float "unit_cost"
    t.index ["category_small_cd"], name: "index_products_on_category_small_cd"
  end

  create_table "receipts", force: :cascade do |t|
    t.date "sales_ymd", null: false
    t.integer "sales_epoch", null: false
    t.string "store_cd", null: false
    t.integer "receipt_no", null: false
    t.integer "receipt_sub_no"
    t.string "customer_id", null: false
    t.string "product_cd", null: false
    t.integer "quantity", null: false
    t.integer "amount", null: false
    t.index ["sales_ymd", "store_cd", "receipt_no", "receipt_sub_no"], name: "receipts_index", unique: true
  end

  create_table "stores", primary_key: "store_cd", id: :string, force: :cascade do |t|
    t.string "store_name"
    t.string "prefecture_cd"
    t.string "prefecture"
    t.string "address"
    t.string "address_kana"
    t.string "tel_no"
    t.decimal "longitude", precision: 11, scale: 8
    t.decimal "latitude", precision: 11, scale: 8
    t.string "floor_area"
    t.index ["prefecture_cd"], name: "index_stores_on_prefecture_cd"
  end

end
