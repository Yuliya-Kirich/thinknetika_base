class User < ApplicationRecord
  def initialize(current_user)
  @current_user = current_user
  end

  def search_test(level)
    Test.joins('JOIN users_sessions on users_sessions.test_id=tests.id').where('level=?', level).where('user_id==?', @current_user)
  end
end

