# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141207020720) do

  create_table "races", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "race_id"
    t.integer  "duration"
    t.date     "date"
    t.text     "comment"
    t.text     "timing_url"
    t.text     "strava_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wind"
    t.integer  "fastest_duration"
    t.integer  "median_duration"
    t.string   "position"
    t.string   "finishers"
  end

  add_index "results", ["race_id"], name: "index_results_on_race_id"
  add_index "results", ["user_id"], name: "index_results_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "email",              limit: 255
    t.string   "password",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
