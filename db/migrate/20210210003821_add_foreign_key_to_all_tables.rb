class AddForeignKeyToAllTables < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :questions, :tests
    add_foreign_key :answers, :questions
    add_foreign_key :answers, :users
    add_foreign_key :tests, :categories
  end
end
