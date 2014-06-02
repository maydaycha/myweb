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

ActiveRecord::Schema.define(version: 20140602182641) do

  create_table "facebooks", force: true do |t|
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauths", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
  end

  create_table "project_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_public_messages", force: true do |t|
    t.integer  "project_id"
    t.string   "from_user_name"
    t.integer  "from_user_id"
    t.datetime "datetime"
    t.text     "text"
    t.string   "attachmentlink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text_chinese"
    t.integer  "word_count",     default: 0
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
    t.text     "public_message"
    t.integer  "word_count",             default: 0
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translators", force: true do |t|
    t.string   "account"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "category",   default: 0
  end

  create_table "user_authentications", force: true do |t|
    t.string   "user_id",      null: false
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "token"
    t.string   "token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_certifications", force: true do |t|
    t.string   "name"
    t.string   "source"
    t.string   "get_time"
    t.string   "description", limit: 1000
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_durations", force: true do |t|
    t.integer  "user_id"
    t.datetime "start_at"
    t.boolean  "is_head"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_educations", force: true do |t|
    t.string   "school"
    t.string   "department"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", limit: 1000
  end

  create_table "user_employer_companies", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name",                                          null: false
    t.string   "last_name",                                           null: false
    t.string   "company_name",                                        null: false
    t.binary   "picture",            limit: 16777215
    t.string   "brief_introduction"
    t.string   "introduction"
    t.string   "website"
    t.string   "country_code"
    t.string   "city"
    t.integer  "zip"
    t.string   "time_zone",                           default: "UTC"
    t.integer  "vat_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_employer_personals", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name",                                          null: false
    t.string   "last_name",                                           null: false
    t.binary   "picture",            limit: 16777215
    t.string   "brief_introduction"
    t.string   "introduction"
    t.string   "website"
    t.string   "country_code"
    t.string   "city"
    t.integer  "zip"
    t.string   "time_zone",                           default: "UTC"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_experiences", force: true do |t|
    t.string   "organization"
    t.string   "office"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",  limit: 1000
  end

  create_table "user_favorites", force: true do |t|
    t.integer  "favorite_user_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_portfolios", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "main_skill_id"
    t.integer  "sub_skill_id"
    t.binary   "picture1",         limit: 16777215
    t.string   "skill"
    t.binary   "document_content", limit: 2147483647
    t.string   "document_name"
  end

  create_table "user_skill_categories", force: true do |t|
    t.integer  "user_id"
    t.integer  "main_skill_id"
    t.string   "sub_skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_translations", force: true do |t|
    t.integer  "user_id"
    t.string   "language"
    t.text     "description_in_short"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_in_detail"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                   default: "",    null: false
    t.string   "encrypted_password",                      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                         default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "username",                                                null: false
    t.string   "first_name",                                              null: false
    t.string   "last_name",                                               null: false
    t.string   "country_code"
    t.string   "time_zone",                               default: "UTC"
    t.string   "how_to_know"
    t.boolean  "receive_information"
    t.binary   "picture",                limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brief_introduction"
    t.text     "introduction"
    t.string   "image"
    t.integer  "worker_type"
    t.float    "hourly_pay"
    t.string   "city"
    t.integer  "zip"
    t.integer  "step"
    t.string   "sketch"
    t.string   "current_role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
