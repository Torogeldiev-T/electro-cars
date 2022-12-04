class CreateChargingStations < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE SEQUENCE sn_seq;
          CREATE OR REPLACE FUNCTION
          nextval_special()
          RETURNS varchar
          LANGUAGE sql
          AS
          $$
              SELECT 'CS-'||to_char(nextval('sn_seq'), 'FM000000');#{' '}
          $$;
        SQL

        create_table :charging_stations do |t|
          t.string :station_serial_number, null: false, default: -> { 'nextval_special()' }
          t.references :location, foreign_key: true
          t.timestamps
        end
      end

      dir.down do
        execute <<-SQL
          DROP TABLE charging_stations;
          DROP SEQUENCE sn_seq;
          DROP FUNCTION nextval_special();
        SQL
      end
    end
  end
end
