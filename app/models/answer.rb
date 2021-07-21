class Answer < ApplicationRecord
  belongs_to :question

  scope :correct, -> {where(correct:1).order(created_at: :asc)}
end
