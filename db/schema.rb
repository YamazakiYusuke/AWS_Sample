ActiveRecord::Schema.define(version: 2020_11_04_052730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "limit", default: "2021-01-01 00:00:00", null: false
    t.string "status", default: "未着手"
    t.integer "priority", default: 0
  end

end
