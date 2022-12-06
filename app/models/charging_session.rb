# == Schema Information
#
# Table name: charging_sessions
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  consumed_power    :decimal(6, 2)    default(0.0)
#  duration_in_hours :decimal(4, 2)    default(0.0)
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
  after_create :occupy_connector

  belongs_to :user
  belongs_to :connector

  delegate :name, to: :location, prefix: true
  delegate :full_name, :phone_number, to: :user, prefix: true

  validate :user_can_start_session, on: :create

  def location
    connector.charging_station.location
  end

  def stop
    if active
      finalize_charging_session
      release_connector
    else
      errors.add(:base, :has_been_stopped, message: 'Session was already stopped')
    end
  end

  private

  def user_can_start_session
    unless user_has_no_active_sessions?
      errors.add(:user, :has_active_session,
                 message: 'already has active charging session')
    end
    unless user_and_connector_plugs_match?
      errors.add(:user, :plug_do_not_match,
                 message: 'does not have matching plug')
    end
    errors.add(:connector, :occupied, message: 'has already been occupied') unless connector_is_free?
  end

  def user_and_connector_plugs_match?
    user.plug == connector.plug || user.adapters.where(plug_from: user.plug, plug_to: connector.plug).any?
  end

  def user_has_no_active_sessions?
    !user.charging_sessions.find_by(active: true)
  end

  def connector_is_free?
    connector.current_state == Connector::STATES['free']
  end

  def occupy_connector
    connector.update!(current_state: Connector::STATES['occupied'])
  end

  def finalize_charging_session
    duration = (Time.now - created_at) / 3600.0
    consumed_power = duration * connector.power

    update(active: false, consumed_power:, duration_in_hours: duration)
  end

  def release_connector
    connector.update(current_state: Connector::STATES["free"])
  end
end
