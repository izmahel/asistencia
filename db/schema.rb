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

ActiveRecord::Schema.define(version: 2021_04_13_183951) do

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "location_id"
    t.index ["user_id"], name: "index_departments_on_user_id"
  end

  create_table "labcitas", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "id", default: 0, null: false
    t.string "name", collation: "utf8mb4_general_ci"
    t.integer "start"
    t.integer "end"
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "max"
  end

  create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.date "work_date"
    t.boolean "h1"
    t.boolean "h2"
    t.boolean "q1"
    t.boolean "q2"
    t.boolean "q3"
    t.boolean "q4"
    t.boolean "q5"
    t.boolean "q6"
    t.boolean "q7"
    t.boolean "q8"
    t.boolean "q9"
    t.boolean "q10"
    t.boolean "q11"
    t.boolean "q12"
    t.boolean "q13"
    t.boolean "q14"
    t.text "notes"
    t.datetime "in"
    t.datetime "out"
    t.text "user_notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "who"
    t.integer "status"
    t.string "temperature"
    t.boolean "passed"
    t.integer "start"
    t.integer "end"
    t.integer "appointment_id"
    t.integer "laboratory_id"
    t.string "out_notes"
    t.integer "edit_by"
    t.string "edit_notes"
    t.datetime "edit_date"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "schedules_bak", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "id", default: 0, null: false
    t.bigint "user_id"
    t.date "work_date"
    t.boolean "h1"
    t.boolean "h2"
    t.boolean "q1"
    t.boolean "q2"
    t.boolean "q3"
    t.boolean "q4"
    t.boolean "q5"
    t.boolean "q6"
    t.boolean "q7"
    t.boolean "q8"
    t.boolean "q9"
    t.boolean "q10"
    t.boolean "q11"
    t.boolean "q12"
    t.boolean "q13"
    t.boolean "q14"
    t.text "notes"
    t.datetime "in"
    t.datetime "out"
    t.text "user_notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "who"
    t.integer "status"
    t.string "temperature"
    t.boolean "passed"
    t.integer "start"
    t.integer "end"
    t.integer "appointment_id"
    t.integer "laboratory_id"
    t.string "out_notes"
  end

  create_table "student_supervisors", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_advisor"
    t.index ["student_id"], name: "index_student_supervisors_on_student_id"
    t.index ["user_id"], name: "index_student_supervisors_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "identificator"
    t.integer "status"
    t.bigint "department_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin"
    t.boolean "course"
    t.boolean "unlimited"
    t.boolean "vulnerable"
    t.boolean "is_student"
    t.integer "location_id"
    t.index ["department_id"], name: "index_users_on_department_id"
  end

end
