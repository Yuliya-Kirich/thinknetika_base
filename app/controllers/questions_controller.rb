class Admin::QuestionsController < ApplicationController
  before_action :find_question, only: %i[show]
  before_action :users_spoof_check, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found



  def show; end




  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Такого вопроса нет'
  end

  def users_spoof_check
    if user_signed_in?
      redirect_to root_url unless current_user.id == @question.test.user_id
    else
      redirect_to user_confirmation_url
    end
  end
end
