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

ActiveRecord::Schema.define(version: 2018_05_25_150533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "venue_name"
    t.string "address_formatted"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.integer "address_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "session_id"
    t.integer "present", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_attendances_on_session_id"
    t.index ["student_id", "session_id"], name: "index_attendances_on_student_id_and_session_id", unique: true
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "subject_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "frequency"
    t.integer "number_of_sessions"
    t.bigint "address_id"
    t.integer "min_capacity"
    t.integer "max_capacity"
    t.text "notes"
    t.integer "session_length"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["address_id"], name: "index_courses_on_address_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id"
  end

  create_table "proficiencies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subject_id"
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_proficiencies_on_subject_id"
    t.index ["user_id"], name: "index_proficiencies_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "course_id"
    t.date "date", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_sessions_on_course_id"
  end

  create_table "student_rosters", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_student_rosters_on_course_id"
    t.index ["student_id", "course_id"], name: "index_student_rosters_on_student_id_and_course_id", unique: true
    t.index ["student_id"], name: "index_student_rosters_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "address_id"
    t.string "email"
    t.string "phone"
    t.date "birth_date"
    t.integer "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_students_on_address_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.integer "role"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "volunteer_rosters", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_volunteer_rosters_on_course_id"
    t.index ["user_id"], name: "index_volunteer_rosters_on_user_id"
  end

  add_foreign_key "attendances", "sessions"
  add_foreign_key "attendances", "students"
  add_foreign_key "courses", "addresses"
  add_foreign_key "courses", "subjects"
  add_foreign_key "proficiencies", "subjects"
  add_foreign_key "proficiencies", "users"
  add_foreign_key "sessions", "courses"
  add_foreign_key "student_rosters", "courses"
  add_foreign_key "student_rosters", "students"
  add_foreign_key "students", "addresses"
  add_foreign_key "users", "addresses"
  add_foreign_key "volunteer_rosters", "courses"
  add_foreign_key "volunteer_rosters", "users"
end
