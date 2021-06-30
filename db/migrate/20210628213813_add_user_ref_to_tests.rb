class AddUserRefToTests < ActiveRecord::Migration[6.0]
  def change
    add_reference :tests, :user
  end
end
