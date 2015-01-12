# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140901150402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analysts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "base_values", force: true do |t|
    t.integer  "company_id"
    t.integer  "revenue_type"
    t.float    "base_growth_value"
    t.float    "base_value"
    t.float    "growth_value"
    t.float    "value"
    t.integer  "year"
    t.integer  "is_base"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifications", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "analyst_id"
    t.integer  "status_id"
    t.integer  "confidence_level_id"
    t.integer  "nda_id"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.string   "website"
    t.string   "parent_company"
    t.integer  "company_type_id"
    t.string   "CEO"
    t.string   "PSL"
    t.integer  "no_of_DCS"
    t.string   "dclocation"
    t.string   "dcpartner"
    t.float    "revenue"
    t.string   "revenue_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_classifications", force: true do |t|
    t.integer  "company_id"
    t.integer  "classification_id"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_geos", force: true do |t|
    t.integer  "company_id"
    t.integer  "geo_id"
    t.float    "year"
    t.string   "value"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_growths", force: true do |t|
    t.integer  "company_id"
    t.integer  "growth_id"
    t.float    "value"
    t.string   "year"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_investors", force: true do |t|
    t.integer  "company_id"
    t.string   "investor"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_regions_growths", force: true do |t|
    t.integer  "region_id"
    t.integer  "company_id"
    t.float    "value"
    t.string   "year"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_revenues", force: true do |t|
    t.integer  "company_id"
    t.integer  "revenue_id"
    t.float    "year"
    t.integer  "value"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_types", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confidence_levels", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geos", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "growths", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investors", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legend_values", force: true do |t|
    t.integer  "legend_id"
    t.string   "range"
    t.string   "value"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legends", force: true do |t|
    t.string   "FX_rate"
    t.string   "currency"
    t.string   "name"
    t.string   "currency_prefix"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ndas", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "percent_ranges", force: true do |t|
    t.integer  "value"
    t.string   "range"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revenue_ranges", force: true do |t|
    t.integer  "value"
    t.string   "range"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revenues", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "createdOn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "fullname"
    t.string   "username"
    t.string   "password"
    t.integer  "user_type_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
