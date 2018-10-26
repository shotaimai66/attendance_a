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

ActiveRecord::Schema.define(version: 20181008091351) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "basic_work_time"
    t.string "password_confirmation"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "sv", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "team"
    t.datetime "d_start_worktime"
    t.datetime "d_end_worktime"
    t.datetime "basic_work_time"
    t.integer "worker_number"
    t.string "worker_id"
    t.text "working"
  end

  create_table "works", force: :cascade do |t|
    t.date "day"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.boolean "check_box"
    t.boolean "check_tomorrow"
    t.datetime "endtime_plan"
    t.datetime "starttime_change"
    t.datetime "endtime_change"
    t.text "work_content"
    t.string "over_check"
    t.string "month_check"
    t.string "work_check"
    t.index ["user_id"], name: "index_works_on_user_id"
  end

end
