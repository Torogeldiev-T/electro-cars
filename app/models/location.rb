class Location < ApplicationRecord
  has_many :charging_stations, dependent: :restrict_with_exception

  validates_presence_of :name, :latitude, :longitude
end