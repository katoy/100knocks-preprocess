# == Schema Information
#
# Table name: customers
#
#  address              :string
#  age                  :integer
#  application_date     :string
#  application_store_cd :string
#  birth_day            :date
#  customer_name        :string
#  gender               :string
#  gender_cd            :string
#  postal_cd            :string
#  status_cd            :string
#  customer_id          :string           not null, primary key
#
class Customer < ApplicationRecord
  self.primary_key = :customer_id

  has_many :receipts
end
