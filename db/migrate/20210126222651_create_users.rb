class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :test, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
