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

ActiveRecord::Schema[7.1].define(version: 2023_11_30_030045) do
  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "full_name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "custom_prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "price"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_custom_prices_on_room_id"
  end

  create_table "guesthouses", force: :cascade do |t|
    t.string "name"
    t.string "legal_name"
    t.string "cnpj"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "district"
    t.string "state"
    t.string "city"
    t.string "cep"
    t.text "description"
    t.string "accepted_payment_methods"
    t.boolean "accepts_pets"
    t.text "policies"
    t.time "check_in_time"
    t.time "check_out_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available", default: true
    t.integer "owner_id", null: false
    t.index ["owner_id"], name: "index_guesthouses_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.date "entry_date"
    t.date "departure_date"
    t.integer "number_of_guests"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total_price"
    t.integer "client_id", null: false
    t.string "code"
    t.integer "guesthouse_id", null: false
    t.string "status"
    t.datetime "check_in_date"
    t.datetime "checkout_date"
    t.string "payment_method"
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["code"], name: "index_reservations_on_code"
    t.index ["guesthouse_id"], name: "index_reservations_on_guesthouse_id"
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.integer "reservation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guesthouse_id", null: false
    t.string "response_to_review"
    t.index ["guesthouse_id"], name: "index_reviews_on_guesthouse_id"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "dimension"
    t.integer "max_occupancy"
    t.decimal "daily_rate"
    t.boolean "has_private_bathroom"
    t.boolean "has_balcony"
    t.boolean "has_air_conditioning"
    t.boolean "has_tv"
    t.boolean "has_wardrobe"
    t.boolean "is_accessible"
    t.boolean "has_cofre"
    t.boolean "available"
    t.integer "guesthouse_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guesthouse_id"], name: "index_rooms_on_guesthouse_id"
  end

  add_foreign_key "custom_prices", "rooms"
  add_foreign_key "guesthouses", "owners"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "guesthouses"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "reviews", "guesthouses"
  add_foreign_key "reviews", "reservations"
  add_foreign_key "rooms", "guesthouses"
end
