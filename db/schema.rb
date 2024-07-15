# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_15_150507) do
  create_table "comments", charset: "utf8", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_comments_on_list_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_favorites_on_list_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "list_tags", charset: "utf8", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_tags_on_list_id"
    t.index ["tag_id"], name: "index_list_tags_on_tag_id"
  end

  create_table "lists", charset: "utf8", force: :cascade do |t|
    t.string "list_title", null: false
    t.text "description"
    t.string "song_title", null: false
    t.string "reading"
    t.integer "key_id"
    t.string "singer"
    t.string "link"
    t.string "remarks"
    t.bigint "user_id", null: false
    t.boolean "public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "tags", charset: "utf8", force: :cascade do |t|
    t.string "tag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.date "birthdate", null: false
    t.integer "vocal_range_id"
    t.boolean "direct_messages_enabled", default: false, null: false
    t.text "profile"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "lists"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "lists"
  add_foreign_key "favorites", "users"
  add_foreign_key "list_tags", "lists"
  add_foreign_key "list_tags", "tags"
  add_foreign_key "lists", "users"
end
