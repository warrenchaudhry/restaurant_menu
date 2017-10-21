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

ActiveRecord::Schema.define(version: 20171020083024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "menus", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name"
    t.string "sponsor"
    t.string "event"
    t.string "venue"
    t.string "place"
    t.string "physical_description"
    t.string "occasion"
    t.string "notes"
    t.string "call_number"
    t.string "keywords"
    t.string "language"
    t.date "date"
    t.string "location"
    t.string "location_type"
    t.string "currency"
    t.string "currency_symbol"
    t.string "status"
    t.integer "page_count"
    t.integer "dish_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_menus_on_id"
    t.index ["name"], name: "index_menus_on_name"
  end

end
