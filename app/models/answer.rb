class Answer < ApplicationRecord
  belongs_to :question

  validate :validate_question_to_answer

  scope :correct, -> {where(correct:true)}


  private
  #У одного Вопроса может быть от 1-го до 4-х ответов
  def validate_question_to_answer
    errors.add(:question_id, 'answers limit exceeded') if question.answers.count>4
  end

   def answer_sorting
     correct.order(created_at: :asc)
   end

end

