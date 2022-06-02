class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :body, presence: true
  #У одного Вопроса может быть от 1-го до 4-х ответов
  #validate :question_sensitive_to_answer

  def question_sensitive_to_answer
    errors.add(:question) if validates :answer.count question_id, uniqueness: false

    #НАДО НАПИСАТЬ
  end
end
