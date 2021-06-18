# == Schema Information
#
# Table name: categories
#
#  category_major_cd    :string
#  category_major_name  :string
#  category_medium_cd   :string
#  category_medium_name :string
#  category_small_cd    :string           not null, primary key
#  category_small_name  :string
#
class Category < ApplicationRecord
  self.primary_key = :category_small_cd

  has_many :products, foreign_key: :category_small_cd

  validates :category_small_cd, presence: true
end
