class CreateConnectors < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
        CREATE TYPE plug AS ENUM ('CHAdeMO', 'CCS Combo 2', 'Type 2');
        CREATE TYPE state AS ENUM ('disabled', 'occupied', 'free');
        SQL
      end
      dir.down do
        execute <<-SQL
          DROP TYPE plug;
          DROP TYPE state;
        SQL
      end
    end
    create_table :connectors do |t|
      t.column :current_state, :state, null: false
      t.column :plug, :plug, null: false
      t.decimal :power, precision: 6, scale: 2, null: false
      t.references :charging_station, foreign_key: true
      t.timestamps
    end
    add_index :connectors, %i[current_state plug]
  end
end
