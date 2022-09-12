class RemoveAndAddIndexTestsOnTitleAndLevel < ActiveRecord::Migration[6.0]

  def change

    def remove_index( name: "by_title_level", unique: true)
    end

    def add_index(name: "by_title_level", unique: true, on_delete: :cascade)
    end

  end
end
