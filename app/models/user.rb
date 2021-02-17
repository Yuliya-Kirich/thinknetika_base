class User < ApplicationRecord
  def search(level)
    (User.joins('JOIN tests on users.test_id=tests.id')
         .where('level=?' , level)
         .pluck('test_id'))
         .each do |test_number| pp Test.where('id=?', test_number)
         end
  end
end