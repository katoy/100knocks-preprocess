# == Schema Information
#
# Table name: products
#
#  category_major_cd  :string
#  category_medium_cd :string
#  category_small_cd  :string
#  product_cd         :string           not null, primary key
#  unit_cost          :float
#  unit_price         :float
#
# Indexes
#
#  index_products_on_category_small_cd  (category_small_cd)
#
class Product < ApplicationRecord
  self.primary_key = :product_cd
  belongs_to :category, foreign_key: :category_small_cd
  has_many :receipts, foreign_key: :product_cd

  validates :product_cd, presence: true
end
