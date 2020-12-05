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

ActiveRecord::Schema.define(version: 2020_10_02_052958) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.string "status_attendance"
    t.datetime "attendance_time"
    t.datetime "pick_up_time"
    t.string "pick_up_person"
    t.string "feeling"
    t.float "temp"
    t.datetime "dinner_time"
    t.string "amount_dinner"
    t.datetime "morning_time"
    t.string "amount_morning"
    t.datetime "lunch_time"
    t.string "amount_lunch"
    t.datetime "first_snack"
    t.string "amount_1_snack"
    t.datetime "second_snack"
    t.string "amount_2_snack"
    t.datetime "toilet_time"
    t.string "toilet_status"
    t.datetime "start_night_sleep"
    t.datetime "end_night_sleep"
    t.datetime "start_afternoon_sleep"
    t.datetime "end_afternoon_sleep"
    t.string "status_at_home"
    t.string "status_at_school"
    t.string "info_from_home"
    t.string "info_from_school"
    t.string "reason_of_absence"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_attendances_on_child_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "child_name"
    t.string "age"
    t.date "birthday"
    t.integer "gender"
    t.integer "parent_id"
    t.integer "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_children_on_classroom_id"
    t.index ["parent_id"], name: "index_children_on_parent_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "class_name"
    t.string "class_teacher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parents", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.string "relationship"
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_parents_on_email", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "staff_id"
    t.string "password_digest"
    t.string "remember_digest"
    t.integer "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["classroom_id"], name: "index_teachers_on_classroom_id"
    t.index ["email"], name: "index_teachers_on_email", unique: true
  end

end
