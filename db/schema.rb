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

ActiveRecord::Schema.define(version: 20160317205735) do

  create_table "invites", force: :cascade do |t|
    t.string   "claim_code_hash",                            null: false
    t.boolean  "claimed",                    default: false, null: false
    t.string   "email",                                      null: false
    t.string   "first_name",      limit: 35
    t.string   "last_name",       limit: 45
    t.integer  "owner_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name",      limit: 35
    t.string   "last_name",       limit: 45
    t.string   "email",                                  null: false
    t.integer  "invites_left",               default: 0, null: false
    t.string   "password_digest"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",       default: "",    null: false
    t.string   "color"
    t.text     "raw_content", default: "",    null: false
    t.integer  "view_count",  default: 0,     null: false
    t.integer  "author_id",                   null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "hidden",      default: false, null: false
    t.boolean  "featured",    default: false, null: false
  end

end
