class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true, foreign_key: :current_question_id

  before_validation :before_validation_set_first_question, on: :create
  after_validation :set_next_question, on: :update

  validates :current_question, presence: true

  EXPECTED_RATE = 85

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def question_number
    test.questions.index(current_question) + 1
  end

  def correct_questions_rate
    self.correct_questions * 100 / self.test.questions.count
  end

  def success?
    correct_questions_rate >= EXPECTED_RATE
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    (correct_answers.count == correct_answers.where(id: answer_ids).count) &&
      correct_answers.count == answer_ids.count
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def set_next_question
    self.current_question = next_question
  end
end
