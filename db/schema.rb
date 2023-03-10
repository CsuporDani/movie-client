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

ActiveRecord::Schema[7.0].define(version: 2023_01_17_165918) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cache_hit_counts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "page", default: 1, null: false
    t.integer "hit_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.integer "tmdb_id", null: false
    t.string "overview"
    t.string "poster_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
