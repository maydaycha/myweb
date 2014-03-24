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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20140324021450) do
=======
ActiveRecord::Schema.define(version: 20140323203049) do
>>>>>>> 952af3e72537b2c3e53c0a017f93e110cd9e84a2

  create_table "oauths", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "outside_id"
    t.string   "name"
    t.string   "url"
    t.string   "budget"
    t.string   "require_skills"
    t.datetime "remain_time"
    t.datetime "duration"
    t.string   "from_source"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
<<<<<<< HEAD
    t.string   "name_chinese"
    t.string   "require_skills_chinese"
    t.text     "description_chinese"
=======
>>>>>>> 952af3e72537b2c3e53c0a017f93e110cd9e84a2
  end

end
