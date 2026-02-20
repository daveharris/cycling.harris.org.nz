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

ActiveRecord::Schema[8.1].define(version: 2026_02_23_001238) do
  create_table "races", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "distance"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.date "date"
    t.integer "duration"
    t.integer "fastest_duration"
    t.integer "finishers"
    t.integer "median_duration"
    t.integer "position"
    t.integer "race_id", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "user_id", null: false
    t.string "wind"
    t.index ["race_id"], name: "index_results_on_race_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "results", "races"
  add_foreign_key "results", "users"
  add_foreign_key "sessions", "users"
end
