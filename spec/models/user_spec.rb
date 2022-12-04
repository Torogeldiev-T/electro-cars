# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  full_name    :string           not null
#  phone_number :string           not null
#  plug         :enum             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to be_valid }
    it { is_expected.to have_many(:adapters) }
    it { is_expected.to have_many(:charging_sessions) }
  end

  describe 'validations' do
    it 'is expected to raise validation exception with invalid values' do
      expect { create(:user, full_name: '') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:user, phone_number: 'INVALID PHONE NUMBER') }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
