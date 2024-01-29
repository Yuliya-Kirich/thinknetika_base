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

ActiveRecord::Schema.define(version: 20_240_113_225_243) do
  create_table 'admins', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
  end

  create_table 'answers', force: :cascade do |t|
    t.string 'body', null: false
    t.boolean 'correct', default: false, null: false
    t.integer 'question_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'type_of_category', null: false
    t.integer 'number', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'gists', force: :cascade do |t|
    t.integer 'question_id', null: false
    t.integer 'test_passage_id', null: false
    t.integer 'user_id', null: false
    t.string 'gist_url'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_gists_on_question_id'
    t.index ['test_passage_id'], name: 'index_gists_on_test_passage_id'
    t.index ['user_id'], name: 'index_gists_on_user_id'
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'body', null: false
    t.integer 'test_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['test_id'], name: 'index_questions_on_test_id'
  end

  create_table 'test_passages', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'test_id', null: false
    t.integer 'current_question_id'
    t.integer 'correct_questions', default: 0
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['current_question_id'], name: 'index_test_passages_on_current_question_id'
    t.index ['test_id'], name: 'index_test_passages_on_test_id'
    t.index ['user_id'], name: 'index_test_passages_on_user_id'
  end

  create_table 'tests', force: :cascade do |t|
    t.string 'title', null: false
    t.integer 'level', default: 1, null: false
    t.datetime 'deleted_at'
    t.integer 'category_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'user_id'
    t.index ['category_id'], name: 'index_tests_on_category_id'
    t.index %w[title level], name: 'by_title_level', unique: true
    t.index ['user_id'], name: 'index_tests_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.string 'type', default: 'User', null: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['type'], name: 'index_users_on_type'
  end

  add_foreign_key 'answers', 'questions'
  add_foreign_key 'gists', 'questions'
  add_foreign_key 'gists', 'test_passages'
  add_foreign_key 'gists', 'users'
  add_foreign_key 'questions', 'tests'
  add_foreign_key 'test_passages', 'questions', column: 'current_question_id'
  add_foreign_key 'test_passages', 'tests'
  add_foreign_key 'test_passages', 'users'
  add_foreign_key 'tests', 'categories'
end
