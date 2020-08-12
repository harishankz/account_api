# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_12_173747) do

  create_table "accounts", primary_key: "account_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "account_type"
    t.date "open_date"
    t.string "customer_id"
    t.string "customer_name"
    t.string "branch"
    t.boolean "minor_indicator"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "account_type"], name: "index_accounts_on_account_id_and_account_type"
    t.index ["account_id", "branch"], name: "index_accounts_on_account_id_and_branch"
    t.index ["account_id", "customer_id"], name: "index_accounts_on_account_id_and_customer_id"
    t.index ["account_id", "customer_name"], name: "index_accounts_on_account_id_and_customer_name"
    t.index ["account_id"], name: "index_accounts_on_account_id"
    t.index ["customer_id"], name: "fk_rails_990d303a5d"
  end

  create_table "roles", primary_key: "role_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "role_name"
    t.string "role_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id", "role_code"], name: "index_roles_on_role_id_and_role_code"
    t.index ["role_name", "role_id"], name: "index_roles_on_role_name_and_role_id"
    t.index ["role_name"], name: "index_roles_on_role_name"
  end

  create_table "users", primary_key: "user_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "user_name"
    t.date "date_of_birth"
    t.string "gender"
    t.string "phone_number"
    t.string "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_id", "phone_number"], name: "index_users_on_user_id_and_phone_number"
    t.index ["user_id", "user_name"], name: "index_users_on_user_id_and_user_name"
    t.index ["user_id"], name: "index_users_on_user_id"
  end

  add_foreign_key "accounts", "users", column: "customer_id", primary_key: "user_id"
end
