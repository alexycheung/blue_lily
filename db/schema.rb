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

ActiveRecord::Schema.define(version: 20170612233147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "destroyed_at"
    t.index ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "destroyed_at"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "photo"
    t.string   "size"
    t.string   "condition"
    t.decimal  "purchase_price"
    t.decimal  "sale_price"
    t.text     "description"
    t.string   "company"
    t.string   "color"
    t.integer  "category_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "destroyed_at"
  end

  create_table "properties", force: :cascade do |t|
    t.string   "zillow_url"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "bedrooms"
    t.float    "bathrooms"
    t.integer  "sqft"
    t.decimal  "price"
    t.decimal  "deposit"
    t.string   "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "destroyed_at"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "property_id"
    t.date     "checkin"
    t.date     "checkout"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "destroyed_at"
    t.index ["item_id"], name: "index_reservations_on_item_id", using: :btree
    t.index ["property_id"], name: "index_reservations_on_property_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "company"
    t.string   "role",                   default: "agent"
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.datetime "destroyed_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
