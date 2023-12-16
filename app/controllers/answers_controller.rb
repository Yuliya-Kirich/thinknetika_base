class Admin::AnswersController < ApplicationController
  before_action :set_answer, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_answer_not_found

  def show; end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def rescue_with_answer_not_found
    render plain: 'Такого ответа на вопрос не занесли в списки'
  end

  def users_spoof_check
    if user_signed_in?
      redirect_to root_url if current_user.id != @answer.question.test.user_id
    else
      redirect_to user_confirmation_url
    end
  end
end
