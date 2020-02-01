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
