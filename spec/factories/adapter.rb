FactoryBot.define do
  factory :adapter do
    plug_from { 'CHAdeMO' }
    plug_to { 'Type 2' }
    user
  end
end
