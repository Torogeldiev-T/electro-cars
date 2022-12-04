# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  latitude   :decimal(8, 6)
#  longitude  :decimal(9, 6)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Location < ApplicationRecord
  has_many :charging_stations, dependent: :restrict_with_exception

  validates_presence_of :name, :latitude, :longitude
end
