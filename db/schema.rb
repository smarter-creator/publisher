# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_03_31_174149) do
  create_table "event_occurrences", force: :cascade do |t|
    t.integer "event_id", null: false
    t.datetime "occurrence_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_occurrences_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_datetime", null: false
    t.datetime "end_datetime", null: false
    t.string "recurrence_rule"
    t.boolean "recurring", default: false
    t.integer "publisher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher_id"], name: "index_events_on_publisher_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "event_occurrences", "events"
  add_foreign_key "events", "publishers"
end
