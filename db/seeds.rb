# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

case Rails.env
when 'development'

  3.times do
    latitude = Faker::Number.between(from: -90.0, to: 90.0).round(6)
    longitude = Faker::Number.between(from: -180.0, to: 180.0).round(6)
    name = Faker::Address.unique.street_address
    location = Location.create!(name:, latitude:, longitude:)

    5.times do
      ChargingStation.create!(location:)
    end
  end

  stations = ChargingStation.first(2)
  stations.each do |station|
    power = Faker::Number.between(from: 10.00, to: 30).round(2)
    plugs = ['CHAdeMO', 'CCS Combo 2', 'Type 2']
    idx = Faker::Number.between(from: 0, to: plugs.length - 1)
    5.times do
      station.connectors.create!(power:, plug: plugs[idx], current_state: 'free')
    end
  end

  10.times do |n|
    full_name = Faker::Name.unique.name
    plugs = ['CHAdeMO', 'CCS Combo 2', 'Type 2']
    idx = Faker::Number.between(from: 0, to: Connector::PLUGS.length - 1)
    User.create!(full_name:, phone_number: "+1-541-754-301#{n}", plug: plugs[idx])
  end

when 'production'
end
