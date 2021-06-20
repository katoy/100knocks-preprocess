# == Schema Information
#
# Table name: receipts
#
#  id             :integer          not null, primary key
#  amount         :integer          not null
#  product_cd     :string           not null
#  quantity       :integer          not null
#  receipt_no     :integer          not null
#  receipt_sub_no :integer
#  sales_epoch    :integer          not null
#  sales_ymd      :integer          not null
#  store_cd       :string           not null
#  customer_id    :string           not null
#
# Indexes
#
#  receipts_index  (sales_ymd,store_cd,receipt_no,receipt_sub_no) UNIQUE
#
class Receipt < ApplicationRecord
  belongs_to :customer, foreign_key: :customer_id
  belongs_to :store, foreign_key: :store_cd
  belongs_to :product, foreign_key: :product_cd

  validates :customer_id, presence: true
  validates :store_cd, presence: true
  validates :product_cd, presence: true
end
