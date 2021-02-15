class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :type_category, null: false
      t.integer :number, null: false

      t.timestamps null: false
    end
  end
end
