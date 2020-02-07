# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2015_11_05_073337) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
  end

  create_table "results", force: :cascade do |t|
    t.integer "user_id"
    t.integer "race_id"
    t.integer "duration"
    t.date "date"
    t.text "comment"
    t.string "timing_url"
    t.string "strava_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "wind"
    t.integer "fastest_duration"
    t.integer "median_duration"
    t.integer "position"
    t.integer "finishers"
    t.string "slug"
    t.index ["race_id"], name: "index_results_on_race_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
