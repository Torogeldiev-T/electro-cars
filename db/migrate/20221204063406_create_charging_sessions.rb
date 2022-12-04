class CreateChargingSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :charging_sessions do |t|
      t.decimal :duration_in_hours, precision: 4, scale: 2
      t.decimal :consumed_power, precision: 6, scale: 2
      t.boolean :active
      t.references :user, foreign_key: true 
      t.references :connector, foreign_key: true
      t.timestamps
    end
  end
end
