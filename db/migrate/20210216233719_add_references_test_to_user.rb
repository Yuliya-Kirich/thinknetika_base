class AddReferencesTestToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :test, index: true, foreign_key: true
  end
end
