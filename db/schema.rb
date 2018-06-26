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

ActiveRecord::Schema.define(version: 2018_06_26_013550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "server_id", default: "notNull", null: false
    t.string "friendly_name"
    t.string "service_name", default: "notNull", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_games_on_server_id"
  end

  create_table "scheduled_stops", force: :cascade do |t|
    t.string "game_id", default: "notNull", null: false
    t.datetime "shutdown_time", null: false
    t.datetime "warning_sent_at"
    t.datetime "completed_at"
    t.datetime "canceled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_scheduled_stops_on_game_id"
    t.index ["warning_sent_at"], name: "index_scheduled_stops_on_warning_sent_at"
  end

  create_table "servers", force: :cascade do |t|
    t.string "friendly_name"
    t.string "ip", limit: 15, default: "notNull", null: false
    t.string "username", default: "notNull", null: false
    t.text "keyfile", default: "notNull", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
