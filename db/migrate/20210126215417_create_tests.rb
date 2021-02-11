class CreateTests < ActiveRecord::Migration[6.0]
  def change


      create_table "tests", force: :cascade do |t|
        t.string "title", null: false
        t.integer "level", default: 1, null: false
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.datetime "deleted_at"
        t.integer "category_id"
      end
      add_index(:tests, :title, unique: true)


      create_table "categories", force: :cascade do |t|
        t.string "type", null: false
        t.integer "number", null: false
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
      end
      add_index(:categories, :type, unique: true)

      create_table "answers", force: :cascade do |t|
        t.string "body", null: false
        t.boolean "correct", default: true, null: false
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.integer "user_id"
        t.integer "question_id"
      end

      create_table "questions", force: :cascade do |t|
        t.string "body", null: false
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
        t.integer "test_id"
      end

      create_table "users", force: :cascade do |t|
        t.string "first_name", null: false
        t.string "last_name", null: false
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
      end

      add_foreign_key "answers", "questions"
      add_foreign_key "answers", "users"
      add_foreign_key "questions", "tests"
      add_foreign_key "tests", "categories"
  end
end
