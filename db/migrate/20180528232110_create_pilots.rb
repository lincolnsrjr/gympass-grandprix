class CreatePilots < ActiveRecord::Migration[5.1]
  def change
    create_table :pilots do |t|
      t.string :name, null: false
      t.integer :pilot_number, null: false

      t.timestamps
    end
  end
end
