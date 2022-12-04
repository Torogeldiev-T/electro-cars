class ChargingStation < ApplicationRecord
  # reload model after creation to see newly assigned station_serial_number
  after_create :reload

  belongs_to :location

  validates :station_serial_number, uniqueness: true
end
