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

ActiveRecord::Schema.define(version: 20140331045055) do

  create_table "oauths", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "outside_id"
    t.string   "name"
    t.string   "url"
    t.string   "budget"
    t.string   "require_skills"
    t.string   "from_source"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_chinese"
    t.string   "require_skills_chinese"
    t.text     "description_chinese"
    t.integer  "project_category"
    t.integer  "is_translation",         default: 0
    t.integer  "translators",            default: 0
    t.integer  "currency",               default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "currency_code"
    t.float    "currency_exchangerate"
  end

  create_table "translators", force: true do |t|
    t.string   "account"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "category",   default: 0
  end

  create_table "user_skill_categories", force: true do |t|
    t.integer  "user_id"
    t.integer  "main_skill_id"
    t.integer  "sub_skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", force: true do |t|
    t.integer  "user_id"
    t.string   "skill"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "account"
    t.string   "password"
    t.string   "country_code"
    t.string   "city"
    t.integer  "from"
    t.string   "how_to_know"
    t.boolean  "receive_information"
    t.integer  "siguup_step"
    t.integer  "pay_per_hour"
    t.integer  "zip_code"
    t.binary   "picture"
    t.boolean  "email_verified"
    t.boolean  "phone_verified"
    t.boolean  "payment_verified"
    t.integer  "type"
    t.datetime "last_login_at"
    t.string   "brief_introduction"
    t.text     "detailed_introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
