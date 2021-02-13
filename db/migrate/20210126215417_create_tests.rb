class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :title, null: false, unique: true
      t.integer :level, default: 1, null: false
      t.datetime :deleted_at
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
