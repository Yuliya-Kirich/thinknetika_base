class AddColumnToAllTables < ActiveRecord::Migration[6.0]
  def change
    add_column(:tests, :category_id, :integer)
    add_column(:questions, :test_id, :integer)
    add_column(:answers, :user_id, :integer)
    add_column(:answers, :question_id, :integer)
  end
end
