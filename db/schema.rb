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

ActiveRecord::Schema[8.0].define(version: 2025_04_24_153227) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.string "slug", null: false
  end

  create_table "forums", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.bigint "category_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.index ["category_id"], name: "index_forums_on_category_id"
    t.index ["role_id"], name: "index_forums_on_role_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_messages_on_topic_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.boolean "create_article", default: false
    t.boolean "update_article", default: false
    t.boolean "delete_article", default: false
    t.boolean "lock_topic", default: false
    t.boolean "unlock_topic", default: false
    t.boolean "delete_topic", default: false
    t.boolean "pin_topic", default: false
    t.boolean "unpin_topic", default: false
    t.boolean "delete_message", default: false
    t.boolean "kick_user", default: false
    t.boolean "unkick_user", default: false
    t.boolean "ban_user", default: false
    t.boolean "unban_user", default: false
    t.boolean "banip_user", default: false
    t.boolean "unbanip_user", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "create_forum", default: false
    t.boolean "update_forum", default: false
    t.boolean "delete_forum", default: false
    t.boolean "update_role", default: false
    t.boolean "delete_role", default: false
    t.boolean "update_permission", default: false
    t.integer "priority_permission"
    t.integer "role_id"
    t.boolean "update_topic", default: false
    t.boolean "update_message", default: false
    t.boolean "update_user", default: false
    t.boolean "create_staff", default: false
    t.boolean "promote_user", default: false
    t.boolean "demote_user", default: false
    t.boolean "delete_user", default: false
    t.boolean "create_category", default: false
    t.boolean "update_category", default: false
    t.boolean "delete_category", default: false
    t.index ["role_id"], name: "index_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "label"
    t.string "color"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_id"
    t.bigint "forum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.integer "status", default: 0
    t.datetime "last_message", null: false
    t.index ["forum_id"], name: "index_topics_on_forum_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
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

  add_foreign_key "forums", "categories", on_delete: :cascade
  add_foreign_key "forums", "roles", on_delete: :cascade
  add_foreign_key "messages", "topics", on_delete: :cascade
  add_foreign_key "messages", "users", on_delete: :cascade
  add_foreign_key "permissions", "roles", on_delete: :cascade
  add_foreign_key "topics", "forums", on_delete: :cascade
  add_foreign_key "topics", "users", on_delete: :cascade
  add_foreign_key "users", "roles", on_delete: :cascade
end
