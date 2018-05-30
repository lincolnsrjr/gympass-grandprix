class CreateLapPilots < ActiveRecord::Migration[5.1]
  def change
    create_table :lap_pilots do |t|
      t.datetime :lap_created_at, null: false
      t.references :pilot, foreign_key: true, null: false
      t.datetime :lap_time, null: false
      t.float :average_speed, null: false
      t.references :lap, foreign_key: true, null: false

      t.timestamps
    end
  end
end
