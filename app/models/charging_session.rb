# == Schema Information
#
# Table name: charging_sessions
#
#  id                :bigint           not null, primary key
#  active            :boolean
#  consumed_power    :decimal(6, 2)
#  duration_in_hours :decimal(4, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  connector_id      :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_charging_sessions_on_connector_id  (connector_id)
#  index_charging_sessions_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (connector_id => connectors.id)
#  fk_rails_...  (user_id => users.id)
#
class ChargingSession < ApplicationRecord
  belongs_to :user
  belongs_to :connector

  delegate :name, to: :location, prefix: true
  delegate :full_name, :phone_number, to: :user, prefix: true
end
