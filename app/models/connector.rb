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
class Connector < ApplicationRecord
  belongs_to :charging_station
  has_many :charging_sessions, dependent: :destroy

  PLUGS = {
    'chad' => 'CHAdeMO',
    'combo_2' => 'CCS Combo 2',
    'type_2' => 'Type 2'
  }.freeze

  STATES = {
    'disabled' => 'disabled',
    'occupied' => 'occupied',
    'free' => 'free'
  }.freeze
  validates :plug, inclusion: { in: PLUGS.values }
  validates :current_state, inclusion: { in: STATES.values }
end
