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

ActiveRecord::Schema.define(version: 20150718215007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amznasins", force: :cascade do |t|
    t.string   "asin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photofeeds", force: :cascade do |t|
    t.string   "asin"
    t.string   "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
    t.integer  "amznasin_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "photofeeds", ["amznasin_id"], name: "index_photofeeds_on_amznasin_id", using: :btree
  add_index "photofeeds", ["user_id"], name: "index_photofeeds_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "asin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "account_type"
    t.float    "cashback"
    t.integer  "click"
    t.integer  "feed"
    t.string   "link"
    t.string   "description",     default: "We love Fashion."
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "amzn_email"
    t.string   "real_name"
    t.string   "oauth_token"
    t.float    "funding",         default: 0.0
    t.integer  "visit",           default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
