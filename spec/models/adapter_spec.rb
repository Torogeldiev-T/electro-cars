# == Schema Information
#
# Table name: adapters
#
#  id         :bigint           not null, primary key
#  plug_from  :enum             not null
#  plug_to    :enum             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_adapters_on_plug_from_and_plug_to  (plug_from,plug_to)
#  index_adapters_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'
RSpec.describe Adapter, type: :model do
  subject(:adapter) { build(:adapter) }

  describe 'associations' do
    it { is_expected.to be_valid }
    it { is_expected.to belong_to(:user) }
  end

  describe 'enum validations' do
    it 'is expected to raise validation exception with not included values' do
      expect { create(:adapter, plug_from: 'unknown') }.to raise_error(ActiveRecord::RecordInvalid)
      expect { create(:adapter, plug_to: 'not used') }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'is expected to raise validation exception with same plug_form and plug_to values' do
      expect do
        create(:adapter, plug_from: Connector::PLUGS['type_2'],
                         plug_to: Connector::PLUGS['type_2'])
      end.to raise_error(ActiveRecord::RecordInvalid,
                         "Validation failed: Plug from can't be the same as plug_to")
    end

    it 'creates adapter with type_2 for plug_from and chad for plug_to' do
      adapter = create(:adapter, plug_from: Connector::PLUGS['type_2'], plug_to: Connector::PLUGS['chad'])
      expect(adapter.plug_from).to eq(Connector::PLUGS['type_2'])
      expect(adapter.plug_to).to eq(Connector::PLUGS['chad'])
    end

    it 'creates adapter with combo_2 for plug_from and type_2 for plug_to' do
      adapter = create(:adapter, plug_from: Connector::PLUGS['combo_2'], plug_to: Connector::PLUGS['type_2'])
      expect(adapter.plug_from).to eq(Connector::PLUGS['combo_2'])
      expect(adapter.plug_to).to eq(Connector::PLUGS['type_2'])
    end
  end

  describe 'related objects' do
    it 'raises validation exception when user is nil' do
      expect do
        create(:adapter, user: nil)
      end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: User must exist')
    end
  end
end
