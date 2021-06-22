class Answer < ApplicationRecord
  belongs_to :question, foreign_key: true
end
