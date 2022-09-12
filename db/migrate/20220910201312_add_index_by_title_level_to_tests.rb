class AddIndexByTitleLevelToTests < ActiveRecord::Migration[6.0]
  def change
    add_index(:tests, [ :title, :level ],name: "by_title_level", unique: true)
  end
end
