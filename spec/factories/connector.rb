FactoryBot.define do
  factory :connector do
    power { 20.45 }
    plug { 'CHAdeMO' }
    current_state { 'free' }
    charging_station
  end
end
