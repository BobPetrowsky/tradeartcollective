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

ActiveRecord::Schema.define(version: 20141102225221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: true do |t|
    t.integer "item_id", null: false
    t.string  "image",   null: false
  end

  create_table "items", force: true do |t|
    t.integer  "user_id",                     null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price",                       null: false
    t.string   "name",                        null: false
    t.boolean  "sold",        default: false
  end

  create_table "sales", force: true do |t|
    t.integer "checkout_id",                         null: false
    t.integer "create_time",                         null: false
    t.string  "short_description",                   null: false
    t.string  "long_description"
    t.decimal "amount",                              null: false
    t.string  "payer_name",                          null: false
    t.integer "shipping_address_id"
    t.boolean "shipped",             default: false
    t.boolean "refunded",            default: false
    t.integer "user_id",                             null: false
    t.string  "payer_email",                         null: false
    t.integer "item_id",                             null: false
  end

  create_table "shippings", force: true do |t|
    t.integer "sale_id",  null: false
    t.string  "name"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "country"
  end

  create_table "users", force: true do |t|
    t.string  "email",              null: false
    t.string  "wepay_access_token"
    t.integer "wepay_account_id"
    t.string  "name",               null: false
    t.string  "location"
    t.string  "image",              null: false
    t.text    "story"
    t.string  "video"
    t.string  "background"
    t.string  "border"
  end

end
