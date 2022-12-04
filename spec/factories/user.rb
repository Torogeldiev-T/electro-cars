FactoryBot.define do
  factory :user do
    full_name { 'John Doe' }
    phone_number { '+1-541-754-3010' }
    plug { Connector::PLUGS['type_2'] }
  end
end
