class User < ApplicationRecord
  has_many :users_session

  def search_test(level)
    Test.joins('JOIN users_sessions on users_sessions.test_id=tests.id').where('level=?', level).where('user_id = ?', self.id).pluck(:title)
  end
end