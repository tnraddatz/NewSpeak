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

ActiveRecord::Schema.define(version: 2019_01_11_143636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.text "description"
    t.text "source_id"
    t.text "outlet_name"
    t.text "author"
    t.text "title"
    t.text "url"
    t.text "urltoimage"
    t.datetime "published_at"
    t.integer "record_number"
    t.bigint "outlet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["outlet_id"], name: "index_articles_on_outlet_id"
    t.index ["outlet_name", "published_at"], name: "index_articles_on_outlet_name_and_published_at"
    t.index ["url"], name: "index_articles_on_url", unique: true
  end

  create_table "outlets", force: :cascade do |t|
    t.string "outlet_name"
    t.text "imageurl"
    t.text "siteurl"
    t.integer "total_records"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["outlet_name"], name: "index_outlets_on_outlet_name"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "outlets"
end
