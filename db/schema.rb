# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_220_423_201_610) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  # These are custom enum types that must be created before they can be used in the schema definition
  create_enum 'vehicle_type', %w[campervan sailboat motorboat RV bicycle]

  create_table 'customers', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'email', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_customers_on_email', unique: true
  end

  create_table 'vehicles', force: :cascade do |t|
    t.enum 'vehicle_type', null: false, as: 'vehicle_type'
    t.string 'name', null: false
    t.integer 'length_feet', null: false
    t.bigint 'customer_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['customer_id'], name: 'index_vehicles_on_customer_id'
  end

  add_foreign_key 'vehicles', 'customers'
end
