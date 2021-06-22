class Question < ApplicationRecord
  belongs_to :test, foreign_key: true
  has_one :answer
end
