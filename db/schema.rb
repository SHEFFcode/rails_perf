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

ActiveRecord::Schema[7.0].define(version: 202307231) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "minions", force: :cascade do |t|
    t.bigint "thing_id"
    t.string "mcol0"
    t.string "mcol1"
    t.string "mcol2"
    t.string "mcol3"
    t.string "mcol4"
    t.string "mcol5"
    t.string "mcol6"
    t.string "mcol7"
    t.string "mcol8"
    t.string "mcol9"
    t.index ["thing_id"], name: "index_minions_on_thing_id"
  end

  create_table "things", force: :cascade do |t|
    t.string "col0"
    t.string "col1"
    t.string "col2"
    t.string "col3"
    t.string "col4"
    t.string "col5"
    t.string "col6"
    t.string "col7"
    t.string "col8"
    t.string "col9"
  end

end
