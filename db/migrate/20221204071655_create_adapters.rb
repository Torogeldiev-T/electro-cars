class CreateAdapters < ActiveRecord::Migration[7.0]
  def change
    create_table :adapters do |t|
      t.column :plug_from, :plug, null: false
      t.column :plug_to, :plug, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :adapters, %i[plug_from plug_to]
  end
end
