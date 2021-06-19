# == Schema Information
#
# Table name: geocodes
#
#  id           :integer          not null, primary key
#  address      :string
#  city         :string
#  full_address :string           not null
#  latitude     :decimal(11, 8)   not null
#  longitude    :decimal(11, 8)   not null
#  postal_cd    :string
#  prefecture   :string
#  street       :string
#  town         :string
#
# Indexes
#
#  index_geocodes_on_full_address  (full_address)
#
class Geocode < ApplicationRecord
end
