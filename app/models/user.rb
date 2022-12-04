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
class User < ApplicationRecord
  has_many :adapters
  has_many :charging_sessions, dependent: :destroy

  validates :phone_number, presence: true, length: { maximum: 255 },
                           format: { with: VALID_PHONE_NUMBER_REGEX }
  validates :full_name, presence: true, length: { maximum: 255 }
  validates :plug, inclusion: { in: Connector::PLUGS.values }
end
