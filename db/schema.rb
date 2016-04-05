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

ActiveRecord::Schema.define(version: 20160405022231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "email",                                 null: false
    t.string   "first_name", limit: 35
    t.string   "last_name",  limit: 45
    t.integer  "owner_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "claim_code", limit: 10
    t.boolean  "claimed",               default: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name",      limit: 35
    t.string   "last_name",       limit: 45
    t.string   "email",                                      null: false
    t.integer  "invites_left",               default: 0,     null: false
    t.string   "password_digest"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "slug"
    t.boolean  "admin",                      default: false
  end

  add_index "members", ["slug"], name: "index_members_on_slug", unique: true, using: :btree

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
    t.string   "slug"
    t.boolean  "is_draft",    default: false
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

end
