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

ActiveRecord::Schema[7.1].define(version: 2024_12_19_134251) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["customer", "employee", "admin"]

  create_table "profiles", force: :cascade do |t|
    t.date "birth_day"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.boolean "terms_of_service", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "uid", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "unique_sessions", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "activated", default: false, null: false
    t.datetime "activated_at"
    t.string "activation_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "provider"
    t.jsonb "provider_settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "role", default: "customer", enum_type: "user_role"
    t.datetime "deleted_at"
    t.string "google_secret"
    t.integer "mfa_secret"
    t.string "uid"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "unique_emails", unique: true
  end

  add_foreign_key "sessions", "users"
end
