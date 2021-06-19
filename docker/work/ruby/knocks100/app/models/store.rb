# == Schema Information
#
# Table name: stores
#
#  address       :string
#  address_kana  :string
#  floor_area    :string
#  latitude      :decimal(11, 8)
#  longitude     :decimal(11, 8)
#  prefecture    :string
#  prefecture_cd :string
#  store_cd      :string           not null, primary key
#  store_name    :string
#  tel_no        :string
#
# Indexes
#
#  index_stores_on_prefecture_cd  (prefecture_cd)
#
class Store < ApplicationRecord
  self.primary_key = :store_cd

  has_many :receipts, foreign_key: :store_cd
end
