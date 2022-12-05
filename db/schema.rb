# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_04_071655) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "plug", ["CHAdeMO", "CCS Combo 2", "Type 2"]
  create_enum "state", ["disabled", "occupied", "free"]

  create_table "adapters", force: :cascade do |t|
    t.enum "plug_from", null: false, enum_type: "plug"
    t.enum "plug_to", null: false, enum_type: "plug"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plug_from", "plug_to"], name: "index_adapters_on_plug_from_and_plug_to"
    t.index ["user_id"], name: "index_adapters_on_user_id"
  end

  create_table "charging_sessions", force: :cascade do |t|
    t.decimal "duration_in_hours", precision: 4, scale: 2, default: "0.0"
    t.decimal "consumed_power", precision: 6, scale: 2, default: "0.0"
    t.boolean "active", default: true
    t.bigint "user_id"
    t.bigint "connector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connector_id"], name: "index_charging_sessions_on_connector_id"
    t.index ["user_id"], name: "index_charging_sessions_on_user_id"
  end

  create_table "charging_stations", force: :cascade do |t|
    t.string "station_serial_number", default: -> { "nextval_special()" }, null: false
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_charging_stations_on_location_id"
    t.index ["station_serial_number"], name: "index_charging_stations_on_station_serial_number", unique: true
  end

  create_table "connectors", force: :cascade do |t|
    t.enum "current_state", null: false, enum_type: "state"
    t.enum "plug", null: false, enum_type: "plug"
    t.decimal "power", precision: 6, scale: 2, null: false
    t.bigint "charging_station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charging_station_id"], name: "index_connectors_on_charging_station_id"
    t.index ["current_state", "plug"], name: "index_connectors_on_current_state_and_plug"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.decimal "latitude", precision: 8, scale: 6
    t.decimal "longitude", precision: 9, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "phone_number", null: false
    t.enum "plug", null: false, enum_type: "plug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "adapters", "users"
  add_foreign_key "charging_sessions", "connectors"
  add_foreign_key "charging_sessions", "users"
  add_foreign_key "charging_stations", "locations"
  add_foreign_key "connectors", "charging_stations"
end
