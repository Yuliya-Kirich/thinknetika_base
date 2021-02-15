class User < ApplicationRecord
  def search(level)
    User.joins('JOIN tests on users.test_id=tests.id').where('level=?' , level)
  end
end
