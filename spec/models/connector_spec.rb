# == Schema Information
#
# Table name: connectors
#
#  id                  :bigint           not null, primary key
#  current_state       :enum             not null
#  plug                :enum             not null
#  power               :decimal(6, 2)    not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  charging_station_id :bigint
#
# Indexes
#
#  index_connectors_on_charging_station_id     (charging_station_id)
#  index_connectors_on_current_state_and_plug  (current_state,plug)
#
# Foreign Keys
#
#  fk_rails_...  (charging_station_id => charging_stations.id)
#
require 'rails_helper'

RSpec.describe Connector, type: :model do
  subject(:connector) { build(:connector) }

  describe 'associations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to(:charging_station) }
    it { is_expected.to have_many(:charging_sessions) }
  end

  describe 'enum validations' do
    it 'is expected to raise validation exception with not included values' do
      expect { create(:connector, plug: 'unknown') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:connector, current_state: 'not used') }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'creates connector with type_2 for plug' do
      connector = create(:connector, plug: Connector::PLUGS["type_2"])
      expect(connector.plug).to eq(Connector::PLUGS["type_2"])
    end

    it 'creates connector with combo_2 for plug' do
      connector = create(:connector, plug: Connector::PLUGS["combo_2"])
      expect(connector.plug).to eq(Connector::PLUGS["combo_2"])
    end

    it 'creates connector with occupied for current_state' do
      connector = create(:connector, current_state: Connector::STATES["occupied"])
      expect(connector.current_state).to eq(Connector::STATES["occupied"])
    end

    it 'creates connector with disabled for current_state' do
      connector = create(:connector, current_state: Connector::STATES["disabled"])
      expect(connector.current_state).to eq(Connector::STATES["disabled"])
    end
  end

  describe 'related objects' do
    it 'raises validation exception when charging_station is nil' do
      expect do
        create(:connector, charging_station: nil)
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Charging station must exist')
    end
  end
end
