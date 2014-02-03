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

ActiveRecord::Schema.define(version: 20140203200629) do

  create_table "cards", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.boolean  "in_practice_pile?",        default: false
    t.boolean  "in_reserve_pile?",         default: true
    t.boolean  "in_already_learned_pile?", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stack_id"
    t.integer  "topic_id"
  end

  add_index "cards", ["stack_id"], name: "index_cards_on_stack_id"
  add_index "cards", ["topic_id"], name: "index_cards_on_topic_id"

  create_table "stacks", force: true do |t|
    t.string   "name",               default: "reserve"
    t.integer  "times_viewed_today", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
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

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
