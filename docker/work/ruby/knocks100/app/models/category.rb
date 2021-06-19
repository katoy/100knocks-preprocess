# == Schema Information
#
# Table name: categories
#
#  category_major_cd    :string           not null
#  category_major_name  :string           not null
#  category_medium_cd   :string           not null
#  category_medium_name :string           not null
#  category_small_cd    :string           not null, primary key
#  category_small_name  :string           not null
#
# Indexes
#
#  categories_majaor_index  (category_major_cd)
#  categories_medium_index  (category_medium_cd)
#  categories_small_index   (category_small_cd) UNIQUE
#
class Category < ApplicationRecord
  self.primary_key = :category_small_cd

  has_many :products, foreign_key: :category_small_cd

  validates :category_small_cd, presence: true
end
