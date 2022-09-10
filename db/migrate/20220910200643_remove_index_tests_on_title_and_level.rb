class RemoveIndexTestsOnTitleAndLevel < ActiveRecord::Migration[6.0]
  def change
    remove_index(:tests, [ :title, :level ] )
  end
end
