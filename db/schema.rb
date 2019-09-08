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

ActiveRecord::Schema.define(version: 2019_09_08_151851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "permissions", force: :cascade do |t|
    t.boolean "create_article", default: false
    t.boolean "update_article", default: false
    t.boolean "delete_article", default: false
    t.boolean "undelete_article", default: false
    t.boolean "kill_article", default: false
    t.boolean "lock_topic", default: false
    t.boolean "unlock_topic", default: false
    t.boolean "delete_topic", default: false
    t.boolean "undelete_topic", default: false
    t.boolean "kill_topic", default: false
    t.boolean "pin_topic", default: false
    t.boolean "unpin_topic", default: false
    t.boolean "delete_message", default: false
    t.boolean "undelete_message", default: false
    t.boolean "kill_message", default: false
    t.boolean "kick_user", default: false
    t.boolean "unkick_user", default: false
    t.boolean "ban_user", default: false
    t.boolean "unban_user", default: false
    t.boolean "banip_user", default: false
    t.boolean "unbanip_user", default: false
    t.boolean "kill_user", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "create_forum", default: false
    t.boolean "update_forum", default: false
    t.boolean "delete_forum", default: false
    t.boolean "undelete_forum", default: false
    t.boolean "kill_forum", default: false
    t.boolean "update_role", default: false
    t.boolean "delete_role", default: false
    t.boolean "undelete_role", default: false
    t.boolean "kill_role", default: false
    t.boolean "update_permission", default: false
    t.integer "priority_permission"
    t.integer "role_id"
    t.boolean "create_topic", default: false
    t.boolean "update_topic", default: false
    t.boolean "create_message", default: false
    t.boolean "update_message", default: false
    t.boolean "update_user", default: false
    t.boolean "create_staff", default: false
    t.index ["role_id"], name: "index_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "label"
    t.string "color"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.date "birthdate"
    t.text "description"
    t.string "avatar"
    t.string "music"
    t.string "background"
    t.decimal "coin", precision: 8, scale: 2, default: "0.0"
    t.bigint "role_id"
    t.datetime "last_seen_at"
    t.string "country"
    t.integer "gender"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "permissions", "roles", on_delete: :cascade
  add_foreign_key "users", "roles", on_delete: :cascade
end
