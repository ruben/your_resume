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

ActiveRecord::Schema.define(version: 20140205092723) do

  create_table "certifications", force: true do |t|
    t.string   "name"
    t.string   "authority"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certifications", ["profile_id"], name: "index_certifications_on_profile_id"

  create_table "educations", force: true do |t|
    t.string   "school_name",    null: false
    t.string   "degree",         null: false
    t.string   "field_of_study"
    t.date     "start_date",     null: false
    t.date     "end_date"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["profile_id"], name: "index_educations_on_profile_id"

  create_table "languages", force: true do |t|
    t.string   "name"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["profile_id"], name: "index_languages_on_profile_id"

  create_table "positions", force: true do |t|
    t.string   "company",    null: false
    t.date     "start_date", null: false
    t.date     "end_date"
    t.string   "title",      null: false
    t.text     "summary",    null: false
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["profile_id"], name: "index_positions_on_profile_id"

  create_table "profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "summary"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.text     "description", null: false
    t.string   "name",        null: false
    t.string   "url",         null: false
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["profile_id"], name: "index_projects_on_profile_id"

  create_table "users", force: true do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "uid"
    t.string   "access_token"
    t.datetime "expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
