# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180528233201) do

  create_table "lap_pilots", force: :cascade do |t|
    t.datetime "lap_created_at", null: false
    t.integer "pilot_id", null: false
    t.datetime "lap_time", null: false
    t.float "average_speed", null: false
    t.integer "lap_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lap_id"], name: "index_lap_pilots_on_lap_id"
    t.index ["pilot_id"], name: "index_lap_pilots_on_pilot_id"
  end

  create_table "laps", force: :cascade do |t|
    t.integer "lap_number", null: false
    t.integer "race_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_laps_on_race_id"
  end

  create_table "pilots", force: :cascade do |t|
    t.string "name", null: false
    t.integer "pilot_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade do |t|
    t.string "name", null: false
    t.integer "pilot_id"
    t.datetime "best_lap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pilot_id"], name: "index_races_on_pilot_id"
  end

end
