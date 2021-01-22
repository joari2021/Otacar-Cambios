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

ActiveRecord::Schema.define(version: 2021_01_21_174509) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "avalaible_banks", force: :cascade do |t|
    t.string "bank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bank_brasils", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "country"
    t.string "cpf"
    t.string "bank"
    t.string "number_agency"
    t.string "number_account"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "status", default: "activo"
    t.string "permit_delete", default: "permit"
    t.boolean "view", default: true
    t.integer "transactions_in_process", default: 0
    t.boolean "deposit_for_loterica", default: false
    t.integer "cupos_for_loterica", default: 3
    t.index ["user_id"], name: "index_bank_brasils_on_user_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "identidy"
    t.string "country"
    t.string "number_account"
    t.string "type_account"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", default: 1, null: false
    t.string "last_name", default: ""
    t.string "banco"
    t.string "type_document"
    t.string "status", default: "activo"
    t.string "permit_delete", default: "permit"
    t.boolean "view", default: true
    t.integer "transactions_in_process", default: 0
    t.index ["user_id"], name: "index_banks_on_user_id"
  end

  create_table "config_loterica_deposits", force: :cascade do |t|
    t.integer "prioridad_min_1"
    t.integer "prioridad_min_2"
    t.integer "prioridad_min_3"
    t.integer "prioridad_max_1"
    t.integer "prioridad_max_2"
    t.integer "prioridad_max_3"
  end

  create_table "digital_payments", force: :cascade do |t|
    t.string "country"
    t.string "name"
    t.string "last_name"
    t.string "number_phone"
    t.string "payment_method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "status", default: "activo"
    t.string "permit_delete", default: "permit"
    t.boolean "view", default: true
    t.integer "transactions_in_process", default: 0
    t.index ["user_id"], name: "index_digital_payments_on_user_id"
  end

  create_table "mobile_payments", force: :cascade do |t|
    t.string "country"
    t.string "bank"
    t.string "number_phone"
    t.string "document"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "status", default: "activo"
    t.string "permit_delete", default: "permit"
    t.boolean "view", default: true
    t.integer "transactions_in_process", default: 0
    t.index ["user_id"], name: "index_mobile_payments_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "emisor"
    t.string "content"
    t.string "asunto"
    t.boolean "view", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "dato_clave"
    t.index ["user_id"], name: "index_notifications_on_user_id"
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
    t.string "rate_argentina", default: "0,00"
    t.string "rate_argentina_min", default: "0,00"
    t.string "rate_colombia", default: "0,00"
    t.string "rate_colombia_min", default: "0,00"
    t.string "monto_min_argentina", default: "0,00"
    t.string "monto_min_brasil", default: "0,00"
    t.string "monto_min_chile", default: "0,00"
    t.string "monto_min_colombia", default: "0,00"
    t.string "monto_min_ecuador", default: "0,00"
    t.string "monto_min_españa", default: "0,00"
    t.string "monto_min_panama", default: "0,00"
    t.string "monto_min_peru", default: "0,00"
    t.string "monto_min_portugal", default: "0,00"
    t.string "monto_min_usa", default: "0,00"
    t.string "monto_min_venezuela", default: "0,00"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "metodo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", default: 1, null: false
    t.string "status", default: "en proceso"
    t.decimal "monto_envio", precision: 18, scale: 2
    t.decimal "monto_a_recibir", precision: 18, scale: 2
    t.string "account_destinity_usuario"
    t.string "account_destinity_admin"
    t.string "country_destinity"
    t.string "motivo_rechazo"
    t.string "num_id", default: ""
    t.string "comprobante_pago_otacar"
    t.string "comprobante_pago_usuario"
    t.string "sub_monto_a_recibir_1"
    t.string "sub_monto_a_recibir_2"
    t.string "sub_monto_a_recibir_3"
    t.string "comprobante_pago_usuario2"
    t.string "comprobante_pago_usuario3"
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
    t.string "num_referidor"
    t.integer "permission_level", default: 1
    t.string "second_name"
    t.string "second_surname"
    t.string "document"
    t.string "status_referencia", default: "indefinido"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallet_with_users", force: :cascade do |t|
    t.string "country"
    t.string "name"
    t.string "last_name"
    t.string "wallet_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "usuario"
    t.string "status", default: "activo"
    t.string "permit_delete", default: "permit"
    t.boolean "view", default: true
    t.integer "transactions_in_process", default: 0
    t.index ["user_id"], name: "index_wallet_with_users_on_user_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "wallet_name"
    t.integer "user_id", null: false
    t.string "status", default: "activo"
    t.string "permit_delete", default: "permit"
    t.boolean "view", default: true
    t.integer "transactions_in_process", default: 0
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_brasils", "users"
  add_foreign_key "banks", "users"
  add_foreign_key "digital_payments", "users"
  add_foreign_key "mobile_payments", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "wallet_with_users", "users"
  add_foreign_key "wallets", "users"
end
