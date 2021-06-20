class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.integer :sales_ymd, null: false
      t.integer :sales_epoch, null: false
      t.string :store_cd, null: false
      t.integer :receipt_no, null: false
      t.integer :receipt_sub_no
      t.string :customer_id, null: false
      t.string :product_cd, null: false
      t.integer :quantity, null: false
      t.integer :amount, null: false
    end

    add_index :receipts, [:sales_ymd, :store_cd, :receipt_no, :receipt_sub_no], unique: true, name: :receipts_index
  end
end
