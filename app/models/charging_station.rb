# == Schema Information
#
# Table name: charging_stations
#
#  id                    :bigint           not null, primary key
#  station_serial_number :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  location_id           :bigint
#
# Indexes
#
#  index_charging_stations_on_location_id            (location_id)
#  index_charging_stations_on_station_serial_number  (station_serial_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class ChargingStation < ApplicationRecord
  # reload model after creation to see newly assigned station_serial_number
  after_create :reload
  
  belongs_to :location
  has_many :connectors, dependent: :destroy

  validates :station_serial_number, uniqueness: true
end
