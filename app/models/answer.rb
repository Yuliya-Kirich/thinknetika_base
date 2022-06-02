class Answer < ApplicationRecord
  belongs_to :question

  validates :question_id, length: { minimum: 1, maximum: 6 }
  validate :validate_question_to_answer


  scope :correct, -> {where(correct:1).order(created_at: :asc)}


  private
  #У одного Вопроса может быть от 1-го до 4-х ответов
  def validate_question_to_answer
    errors.add(:question_id, message: "There must be up to four answers per question") if Answer.count(question_id)>4
  end

end
