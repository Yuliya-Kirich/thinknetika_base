class RenameColumnToCategories < ActiveRecord::Migration[6.0]
  def change
    rename_column(:categories, :type, :type_of_category)
  end
end
