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

ActiveRecord::Schema[7.0].define(version: 2022_10_17_232909) do
  create_table "create_order_of_services", force: :cascade do |t|
    t.string "output_address"
    t.string "output_city"
    t.string "output_state"
    t.string "product_code"
    t.integer "cargo_weight"
    t.string "receiver_address"
    t.string "receiver_city"
    t.string "receiver_state"
    t.string "receiver_name"
    t.string "receiver_cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.date "receiver_birth"
    t.integer "total_distance"
    t.integer "status", default: 0
    t.string "code"
  end

  create_table "delivery_times", force: :cascade do |t|
    t.integer "origin"
    t.integer "destination"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mode_of_transport_id", null: false
    t.integer "hours"
    t.index ["mode_of_transport_id"], name: "index_delivery_times_on_mode_of_transport_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "create_order_of_service_id", null: false
    t.index ["create_order_of_service_id"], name: "index_feedbacks_on_create_order_of_service_id"
  end

  create_table "mode_of_transports", force: :cascade do |t|
    t.string "name"
    t.integer "max_distance"
    t.integer "min_distance"
    t.integer "max_weight"
    t.integer "min_weight"
    t.integer "fixed_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "price_by_weights", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.decimal "price_per_km"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mode_of_transport_id", null: false
    t.index ["mode_of_transport_id"], name: "index_price_by_weights_on_mode_of_transport_id"
  end

  create_table "price_per_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mode_of_transport_id", null: false
    t.index ["mode_of_transport_id"], name: "index_price_per_distances_on_mode_of_transport_id"
  end

  create_table "send_options", force: :cascade do |t|
    t.integer "mode_of_transport_id", null: false
    t.integer "vehicle_id", null: false
    t.integer "create_order_of_service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "estimated_delivery_date"
    t.index ["create_order_of_service_id"], name: "index_send_options_on_create_order_of_service_id"
    t.index ["mode_of_transport_id"], name: "index_send_options_on_mode_of_transport_id"
    t.index ["vehicle_id"], name: "index_send_options_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.string "identification"
    t.string "year_manufacture"
    t.integer "max_load"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sort"
    t.integer "status", default: 0
  end

  add_foreign_key "delivery_times", "mode_of_transports"
  add_foreign_key "feedbacks", "create_order_of_services"
  add_foreign_key "price_by_weights", "mode_of_transports"
  add_foreign_key "price_per_distances", "mode_of_transports"
  add_foreign_key "send_options", "create_order_of_services"
  add_foreign_key "send_options", "mode_of_transports"
  add_foreign_key "send_options", "vehicles"
end
