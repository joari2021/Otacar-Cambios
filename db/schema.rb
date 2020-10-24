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

ActiveRecord::Schema.define(version: 2020_10_23_203921) do

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "identidy"
    t.string "country"
    t.string "bank"
    t.string "number_account"
    t.string "type_account"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", default: 1, null: false
    t.string "last_name", default: ""
    t.index ["user_id"], name: "index_banks_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.string "country"
    t.string "moneda"
    t.string "monto_oferta", default: "0,00"
    t.string "rate_brasil", default: "0,00"
    t.string "rate_brasil_min", default: "0,00"
    t.string "rate_chile", default: "0,00"
    t.string "rate_chile_min", default: "0,00"
    t.string "rate_ecuador", default: "0,00"
    t.string "rate_ecuador_min", default: "0,00"
    t.string "rate_españa", default: "0,00"
    t.string "rate_españa_min", default: "0,00"
    t.string "rate_panama", default: "0,00"
    t.string "rate_panama_min", default: "0,00"
    t.string "rate_peru", default: "0,00"
    t.string "rate_peru_min", default: "0,00"
    t.string "rate_portugal", default: "0,00"
    t.string "rate_portugal_min", default: "0,00"
    t.string "rate_usa", default: "0,00"
    t.string "rate_usa_min", default: "0,00"
    t.string "rate_venezuela", default: "0,00"
    t.string "rate_venezuela_min", default: "0,00"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "monto", precision: 18, scale: 3
    t.string "metodo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", default: 1, null: false
    t.integer "account_destinity", default: 1
    t.integer "payment_bank", default: 1
    t.string "status", default: "enviada"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "last_name"
    t.string "phone"
    t.integer "day"
    t.string "month"
    t.integer "year"
    t.string "gender"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "address"
    t.string "num_user"
    t.integer "permission_level", default: 1
    t.string "second_name"
    t.string "second_surname"
    t.integer "document"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "banks", "users"
  add_foreign_key "transactions", "users"
end
