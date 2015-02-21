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

ActiveRecord::Schema.define(version: 20150221114444) do

  create_table "order_lines", force: :cascade do |t|
    t.integer  "order_id",    limit: 4
    t.integer  "product_id",  limit: 4
    t.integer  "qty",         limit: 4
    t.decimal  "unit_price",            precision: 9, scale: 1
    t.decimal  "total_price",           precision: 9, scale: 1
    t.integer  "customer_id", limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_no",    limit: 255
    t.integer  "customer_id", limit: 4
    t.decimal  "total",                   precision: 9, scale: 1
    t.date     "date"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.decimal  "price",                     precision: 9, scale: 1
    t.boolean  "status",      limit: 1
    t.text     "description", limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",         limit: 255
    t.string   "firstname",     limit: 255
    t.string   "lastname",      limit: 255
    t.string   "password_hash", limit: 255
    t.string   "password_salt", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
