require 'digest/sha1'
class User < ApplicationRecord

  attr_reader :password
  attr_writer :password_confirmation

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authored_tests, foreign_key: :user_id, class_name: 'Test'

  validates :email, presence: true
  validates :password, presence: true, if: Proc.new{ |u| u.password_digest.blank? }
  validates :password, confirmation: true

  def search_test(level)
    tests.where(level: level).where('user_id = ?', id).pluck(:title)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def authenticate(password_string)
    digest(password_string) == self.password_digest ? self : false
  end

  def password=(password_string)
    if password_string.nil?
      self.password_digest = nil
    elsif password_string.present?
      @password = password_string
      self.password_digest = digest(password_string)
    end
  end

  private

  def digest(string)
    Digest::SHA1.hexdigest(string)
  end
end
