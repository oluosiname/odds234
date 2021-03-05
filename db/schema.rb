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

ActiveRecord::Schema.define(version: 2021_03_05_074155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmakers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_competitions_on_name"
  end

  create_table "events", force: :cascade do |t|
    t.string "uid"
    t.string "home_team"
    t.string "away_team"
    t.json "top_odds"
    t.date "date"
    t.time "kickoff"
    t.bigint "competition_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "starts_at"
    t.index ["away_team"], name: "index_events_on_away_team"
    t.index ["competition_id"], name: "index_events_on_competition_id"
    t.index ["home_team"], name: "index_events_on_home_team"
    t.index ["uid"], name: "index_events_on_uid"
  end

  create_table "odds", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "bookmaker_id"
    t.float "home"
    t.float "draw"
    t.float "away"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookmaker_id"], name: "index_odds_on_bookmaker_id"
    t.index ["event_id"], name: "index_odds_on_event_id"
  end

  add_foreign_key "events", "competitions"
  add_foreign_key "odds", "bookmakers"
  add_foreign_key "odds", "events"
end
