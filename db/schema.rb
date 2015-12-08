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

ActiveRecord::Schema.define(version: 20151125201910) do

  create_table "app_course_matchings", force: :cascade do |t|
    t.integer  "student_application_id"
    t.integer  "course_id"
    t.integer  "application_pool_id"
    t.integer  "status"
    t.integer  "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "application_pools", force: :cascade do |t|
    t.string   "year"
    t.string   "semester"
    t.datetime "deadline"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "cid"
    t.string   "section"
    t.string   "name"
    t.integer  "credits"
    t.string   "lecturer_uin"
    t.string   "area"
    t.text     "notes"
    t.string   "suggestion"
    t.integer  "application_pool_id"
    t.string   "description"
    t.integer  "active_term"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "student_applications", force: :cascade do |t|
    t.string   "advisor"
    t.float    "gpa"
    t.string   "course_taken"
    t.string   "course_taed"
    t.string   "preferred_area"
    t.string   "preferred_course"
    t.integer  "application_pool_id"
    t.integer  "user_id"
    t.integer  "active_term"
    t.text     "note"
    t.string   "requester"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uin"
    t.string   "email"
    t.string   "identity"
    t.string   "start_semester"
    t.string   "elpe"
    t.boolean  "guaranteed"
    t.boolean  "active"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
