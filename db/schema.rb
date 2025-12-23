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

ActiveRecord::Schema[8.1].define(version: 2025_12_23_000000) do
  create_table "burrito_fillings", force: :cascade do |t|
    t.integer "burrito_id", null: false
    t.datetime "created_at", null: false
    t.integer "filling_id", null: false
    t.datetime "updated_at", null: false
    t.index ["burrito_id"], name: "index_burrito_fillings_on_burrito_id"
    t.index ["filling_id"], name: "index_burrito_fillings_on_filling_id"
  end

  create_table "burrito_toppings", force: :cascade do |t|
    t.integer "burrito_id", null: false
    t.datetime "created_at", null: false
    t.integer "topping_id", null: false
    t.datetime "updated_at", null: false
    t.index ["burrito_id"], name: "index_burrito_toppings_on_burrito_id"
    t.index ["topping_id"], name: "index_burrito_toppings_on_topping_id"
  end

  create_table "burritos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "size_id", null: false
    t.integer "tortilla_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["size_id"], name: "index_burritos_on_size_id"
    t.index ["tortilla_id"], name: "index_burritos_on_tortilla_id"
    t.index ["user_id"], name: "index_burritos_on_user_id"
  end

  create_table "fillings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sizes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toppings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tortillas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name"
    t.integer "is_admin", limit: 1, default: 0, null: false
    t.string "last_name"
    t.string "password_digest", limit: 60
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "burrito_fillings", "burritos"
  add_foreign_key "burrito_fillings", "fillings"
  add_foreign_key "burrito_toppings", "burritos"
  add_foreign_key "burrito_toppings", "toppings"
  add_foreign_key "burritos", "sizes"
  add_foreign_key "burritos", "tortillas"
  add_foreign_key "burritos", "users"
end
