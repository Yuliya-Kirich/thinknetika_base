class QuestionsController < ApplicationController
  before_action :redirect_url_remember
  before_action :find_test, only: %i[create new]
  before_action :find_question, only: %i[show destroy edit update]
  before_action :users_spoof_check, only: %i[show destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render action: edit
    end
  end

  def destroy
    @question = @question.destroy
    redirect_to @question.test
  end

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

  def question_params
    params.require(:question).permit(:body)
  end

  def users_spoof_check
    if logged_in?
      redirect_to root_url unless current_user.id == @question.test.user_id
    else
      redirect_to login_url
    end
  end
end
