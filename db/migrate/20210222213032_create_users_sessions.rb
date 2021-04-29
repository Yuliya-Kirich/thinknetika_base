class CreateUsersSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :users_sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :test, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
