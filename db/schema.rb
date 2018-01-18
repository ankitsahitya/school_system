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

ActiveRecord::Schema.define(version: 20180114044834) do

  create_table "classrooms", force: :cascade do |t|
    t.integer  "school_id",  limit: 4
    t.integer  "room_no",    limit: 4
    t.integer  "class_no",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "classrooms", ["school_id"], name: "index_classrooms_on_school_id", using: :btree

  create_table "classrooms_teachers", id: false, force: :cascade do |t|
    t.integer "classroom_id", limit: 4
    t.integer "teacher_id",   limit: 4
  end

  add_index "classrooms_teachers", ["classroom_id"], name: "index_classrooms_teachers_on_classroom_id", using: :btree
  add_index "classrooms_teachers", ["teacher_id"], name: "index_classrooms_teachers_on_teacher_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone_no",   limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "school_id",    limit: 4
    t.integer  "classroom_id", limit: 4
    t.string   "name",         limit: 255
    t.string   "address",      limit: 255
    t.string   "phone_no",     limit: 255
    t.string   "gender",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "students", ["classroom_id"], name: "index_students_on_classroom_id", using: :btree
  add_index "students", ["school_id"], name: "index_students_on_school_id", using: :btree

  create_table "students_subjects", id: false, force: :cascade do |t|
    t.integer "student_id", limit: 4
    t.integer "subject_id", limit: 4
  end

  add_index "students_subjects", ["student_id"], name: "index_students_subjects_on_student_id", using: :btree
  add_index "students_subjects", ["subject_id"], name: "index_students_subjects_on_subject_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "subjects_teachers", id: false, force: :cascade do |t|
    t.integer "subject_id", limit: 4
    t.integer "teacher_id", limit: 4
  end

  add_index "subjects_teachers", ["subject_id"], name: "index_subjects_teachers_on_subject_id", using: :btree
  add_index "subjects_teachers", ["teacher_id"], name: "index_subjects_teachers_on_teacher_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.integer  "school_id",  limit: 4
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "phone_no",   limit: 255
    t.string   "gender",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "teachers", ["school_id"], name: "index_teachers_on_school_id", using: :btree

  add_foreign_key "classrooms", "schools"
  add_foreign_key "classrooms_teachers", "classrooms"
  add_foreign_key "classrooms_teachers", "teachers"
  add_foreign_key "students", "classrooms"
  add_foreign_key "students", "schools"
  add_foreign_key "students_subjects", "students"
  add_foreign_key "students_subjects", "subjects"
  add_foreign_key "subjects_teachers", "subjects"
  add_foreign_key "subjects_teachers", "teachers"
  add_foreign_key "teachers", "schools"
end
