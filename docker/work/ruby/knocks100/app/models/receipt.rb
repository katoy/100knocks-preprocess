# == Schema Information
#
# Table name: receipts
#
#  id             :integer          not null, primary key
#  amount         :integer
#  product_cd     :string
#  quantity       :integer
#  receipt_no     :integer
#  receipt_sub_no :integer
#  sales_epoch    :integer
#  sales_ymd      :date
#  store_cd       :string
#  customer_id    :string
#
class Receipt < ApplicationRecord
  belongs_to :customer, foreign_key: :customer_id
  belongs_to :store, foreign_key: :store_cd
  belongs_to :product, foreign_key: :product_cd

  validates :customer_id, presence: true
  validates :store_cd, presence: true
  validates :product_cd, presence: true
end
