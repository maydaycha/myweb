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

ActiveRecord::Schema.define(version: 20150228195720) do

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

  create_table "conversations", force: true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebooks", force: true do |t|
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locales", force: true do |t|
    t.string   "name"
    t.string   "file_name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "main_skill_classes", force: true do |t|
    t.string   "name"
    t.binary   "picture",    limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meet_room_members", force: true do |t|
    t.integer  "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meet_room_id"
    t.integer  "confirmed",    default: 0
  end

  create_table "meet_room_prices", force: true do |t|
    t.integer  "level"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scheme"
  end

  create_table "meet_rooms", force: true do |t|
    t.integer  "room_number"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "case"
    t.integer  "ordered_customer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meet_room_id"
    t.boolean  "is_changable",     default: true
    t.boolean  "is_confirmed",     default: false
    t.integer  "charge",           default: 0
    t.integer  "meet_type"
    t.integer  "time_unit_count"
    t.string   "subject"
    t.text     "description"
  end

  create_table "memos", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "memoContent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "key"
    t.string   "label"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages_of_projects", force: true do |t|
    t.integer  "project_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.integer  "receiver_id"
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

  create_table "project_members", force: true do |t|
    t.integer  "user"
    t.integer  "project_id"
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

  create_table "search_managements", force: true do |t|
    t.string   "category"
    t.boolean  "allow_internal"
    t.boolean  "allow_external"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seos", force: true do |t|
    t.string   "key"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "page"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snapshots", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "mouseClickCount"
    t.integer  "keyboardClickCount"
    t.string   "snapshot"
    t.text     "memoContent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_skill_classes", force: true do |t|
    t.string   "name"
    t.integer  "main_skill_class_id"
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

  create_table "user_contact_people", force: true do |t|
    t.integer  "contact_person"
    t.string   "contact_person_name"
    t.integer  "project_id"
    t.string   "project_name"
    t.integer  "interview_time"
    t.integer  "contact_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_conversations", force: true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.boolean  "deleted"
    t.boolean  "read"
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
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
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

  create_table "working_histories", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "mouseClick"
    t.integer  "keyboardClick"
    t.integer  "lastWorkingTimestamp"
    t.time     "todayWorkingHours",    default: '2000-01-01 00:00:00'
    t.time     "weekWorkingHours",     default: '2000-01-01 00:00:00'
    t.time     "work_start_at"
    t.time     "day_start_count_at",   default: '2000-01-01 00:00:00'
    t.time     "week_start_count_at",  default: '2000-01-01 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", name: "mb_opt_outs_on_conversations_id", column: "conversation_id"

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
