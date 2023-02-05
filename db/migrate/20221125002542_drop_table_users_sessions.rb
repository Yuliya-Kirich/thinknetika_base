class DropTableUsersSessions < ActiveRecord::Migration[6.0]
  def up
    drop_table :users_sessions, if_exists: true
  end
end
