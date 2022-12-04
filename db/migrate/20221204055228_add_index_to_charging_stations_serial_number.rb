class AddIndexToChargingStationsSerialNumber < ActiveRecord::Migration[7.0]
  def change
    add_index :charging_stations, :station_serial_number, unique: true
  end
end
