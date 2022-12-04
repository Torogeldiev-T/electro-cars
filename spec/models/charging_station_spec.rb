require 'rails_helper'

RSpec.describe ChargingStation, type: :model do
  subject(:charging_station) { create(:charging_station) }

  describe 'associations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to(:location) }
  end

  describe 'validations' do
    it 'should raise error if null location is given' do
      expect { create(:charging_station, location: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'station serial numbers uniquness' do
    it 'should have default value' do
      expect(charging_station.station_serial_number).to match('CS-')
    end

    it 'should create different value for new charging station' do
      new_charging_station = create(:charging_station)
      expect(charging_station.station_serial_number).to_not eq(new_charging_station.station_serial_number)
      expect(Location.all.count).to eq(2)
    end

    it 'should raise error if same serial number is given' do
      expect do
        create(:charging_station,
               station_serial_number: charging_station.station_serial_number)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
