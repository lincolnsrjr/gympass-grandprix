class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.string :name, null: false
      t.references :pilot, foreign_key: true
      t.datetime :best_lap
      t.timestamps
    end
  end
end
