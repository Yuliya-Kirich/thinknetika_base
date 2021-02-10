class AddIndexToAllTables < ActiveRecord::Migration[6.0]
  def change
    add_index(:tests, :id, unique: true)
    add_index(:questions, :id, unique: true)
    add_index(:answers, :id, unique: true)
    add_index(:categories, :id, unique: true)
    add_index(:users, :id, unique: true)
  end
end
