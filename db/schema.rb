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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140313035837) do

  create_table "audio_products", :force => true do |t|
    t.integer  "work_id"
    t.string   "artist"
    t.string   "album"
    t.string   "label"
    t.string   "catalog_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "audio_products", ["work_id"], :name => "index_audio_products_on_work_id"

  create_table "clients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "portal_updates", :force => true do |t|
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "portal_updates", ["user_id"], :name => "index_portal_updates_on_user_id"

  create_table "sessions", :force => true do |t|
    t.datetime "login"
    t.datetime "logout"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["user_id"], :name => "index_sessions_on_user_id"

  create_table "statements", :force => true do |t|
    t.string   "quarter"
    t.string   "year"
    t.float    "amount"
    t.string   "filename"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date"
    t.integer  "web_id"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email"
    t.boolean  "admin"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "remember_token"
    t.string   "area_code"
    t.string   "phone_number"
    t.string   "apartment_number"
    t.string   "address_number"
    t.string   "street_name"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "password_digest"
    t.boolean  "pending",                :default => false
    t.integer  "web_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"

  create_table "work_claims", :force => true do |t|
    t.integer  "user_id"
    t.integer  "work_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "mr_share"
    t.integer  "web_id"
  end

  add_index "work_claims", ["user_id"], :name => "index_work_claims_on_user_id"
  add_index "work_claims", ["work_id"], :name => "index_work_claims_on_work_id"

  create_table "works", :force => true do |t|
    t.string   "title"
    t.string   "duration"
    t.date     "copyright_date"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "attachment"
    t.boolean  "pending",        :default => false
  end

end
