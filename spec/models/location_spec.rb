require 'rails_helper'

RSpec.describe Location, type: :model do
  subject(:location) { create(:location) }

  describe 'associations' do
    it { is_expected.to be_valid }
    it { is_expected.to have_many(:charging_stations) }
  end

  describe 'validations' do
    it 'is expected to raise validation exception with empty values' do
      expect { create(:location, name: '') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:location, latitude: '') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
