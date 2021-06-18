# == Schema Information
#
# Table name: geocodes
#
#  id           :integer          not null, primary key
#  address      :string
#  city         :string
#  full_address :string
#  latitude     :decimal(11, 8)
#  longitude    :decimal(11, 8)
#  postal_cd    :string
#  prefecture   :string
#  street       :string
#  town         :string
#
class Geocode < ApplicationRecord
end
