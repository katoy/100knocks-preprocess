class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.date :sales_ymd
      t.integer :sales_epoch
      t.string :store_cd, index: true
      t.integer :receipt_no
      t.integer :receipt_sub_no
      t.string :customer_id, index: true
      t.string :product_cd, index: true
      t.integer :quantity
      t.integer :amount
    end
  end
end
