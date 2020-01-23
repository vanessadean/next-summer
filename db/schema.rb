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

ActiveRecord::Schema.define(version: 2014_10_16_212706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "description"
    t.string "link"
  end

  create_table "activity_tags", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "activity_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "user_activities", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "activity_id"
    t.boolean "done"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "twitter"
    t.string "email"
    t.string "uid"
    t.string "photo_url"
  end

end
