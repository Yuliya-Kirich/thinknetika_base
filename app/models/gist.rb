require 'octokit'

class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :test_passage
  belongs_to :user

  validates :gist_url, presence: true, uniqueness: true
end
