class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index create new]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @question = @test.questions
  end

  def show
  end

  def new
  end

  def create
    @question=@test.questions.new(question_params)
    if @question.save
      render action: :show
    else
      render plain:"Что-то пошло не так!"
    end
  end

  def destroy
    question=@question.destroy
     if question.destroyed?
      redirect_to action: :index, test_id: question.test.id
     else
      render json: question.errors
     end
  end

  private
  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test=Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Такого вопроса нет'
  end

  def question_params
    params.require(:question).permit(:body)
  end

end
