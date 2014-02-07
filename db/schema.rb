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

ActiveRecord::Schema.define(version: 20140206223658) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stack_id"
    t.integer  "topic_id"
  end

  add_index "cards", ["stack_id"], name: "index_cards_on_stack_id", using: :btree
  add_index "cards", ["topic_id"], name: "index_cards_on_topic_id", using: :btree

  create_table "categories", force: true do |t|
    t.text "name"
  end

  create_table "product_copies", force: true do |t|
    t.integer "product_id"
    t.integer "description_id"
  end

  create_table "products_categories", force: true do |t|
    t.integer "id1"
    t.integer "id2"
  end

  create_table "stacks", force: true do |t|
    t.string   "name",               default: "reserve"
    t.integer  "times_viewed_today", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string  "family_name"
    t.string  "given_name"
    t.integer "table_id"
  end

  create_table "tables", force: true do |t|
  end

  create_table "topics", force: true do |t|
    t.string   "name",       default: "general"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "views", force: true do |t|
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

end
