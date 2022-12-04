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
class Adapter < ApplicationRecord
  belongs_to :user

  validate :check_plug_from_and_to
  validates :plug_from, inclusion: { in: Connector::PLUGS.values }
  validates :plug_to, inclusion: { in: Connector::PLUGS.values }

  def check_plug_from_and_to
    errors.add(:plug_from, "can't be the same as plug_to") if plug_from == plug_to
  end
end
