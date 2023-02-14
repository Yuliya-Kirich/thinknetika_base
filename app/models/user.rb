class User < ApplicationRecord
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authored_tests, foreign_key: :user_id, class_name: 'Test'

  validates :email, presence: true

  def search_test(level)
    tests.where(level: level).where('user_id = ?', id).pluck(:title)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
