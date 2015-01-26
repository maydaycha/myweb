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

ActiveRecord::Schema.define(version: 20150126145719) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",               default: "",    null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",                            null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_service",          default: false
    t.boolean  "is_translator",       default: false
    t.integer  "authority_group_id"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree

  create_table "authority_groups", force: true do |t|
    t.string   "name"
    t.boolean  "admin_management"
    t.boolean  "multi_language_management"
    t.boolean  "banner_management"
    t.boolean  "menu_management"
    t.boolean  "category_management"
    t.boolean  "promotion_page_management"
    t.boolean  "footer_management"
    t.boolean  "module_management"
    t.boolean  "search_management"
    t.boolean  "user_management"
    t.boolean  "group_management"
    t.boolean  "payment_management"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebooks", force: true do |t|
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages_of_projects", force: true do |t|
    t.integer  "project_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
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

  create_table "project_questions", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
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
    t.integer  "is_translation",                          default: 0
    t.integer  "translators",                             default: 0
    t.integer  "currency",                                default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "currency_code"
    t.float    "currency_exchangerate"
    t.text     "public_message"
    t.integer  "word_count",                              default: 0
    t.boolean  "is_emergency",                            default: false
    t.integer  "required_user_level",                     default: 1
    t.integer  "work_type"
    t.integer  "visibility",                              default: 1
    t.binary   "file",                   limit: 16777215
    t.integer  "satisfication"
    t.integer  "worked_hours"
    t.string   "worker_location"
    t.integer  "english_level"
    t.boolean  "required_user_intro",                     default: false
    t.integer  "payment_type",                            default: 1
    t.integer  "main_skill"
    t.integer  "sub_skill"
    t.string   "during_time"
    t.integer  "user_id"
    t.text     "public_message_chinese"
  end

  create_table "seos", force: true do |t|
    t.string   "key"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "user_applying_projects", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.float    "expect_hourly_charge"
    t.text     "introduction"
    t.text     "question1"
    t.text     "question2"
    t.text     "question3"
    t.binary   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "user_favorite_projects", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "sub_skill_id"
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
    t.string   "current_role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "websites", force: true do |t|
    t.binary   "logo",                limit: 2147483647
    t.binary   "swiper",              limit: 2147483647
    t.binary   "it_software",         limit: 2147483647
    t.binary   "science_engineer",    limit: 2147483647
    t.binary   "creativity_design",   limit: 2147483647
    t.binary   "sales",               limit: 2147483647
    t.binary   "service",             limit: 2147483647
    t.binary   "business",            limit: 2147483647
    t.binary   "writness",            limit: 2147483647
    t.binary   "consulting",          limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "footer_about_en"
    t.text     "footer_about_tw"
    t.text     "footer_about_cn"
    t.text     "footer_privacy_en"
    t.text     "footer_privacy_tw"
    t.text     "footer_privacy_cn"
    t.text     "footer_termofuse_en"
    t.text     "footer_termofuse_tw"
    t.text     "footer_termofuse_cn"
    t.text     "footer_contact_en"
    t.text     "footer_contact_tw"
    t.text     "footer_contact_cn"
  end

end
