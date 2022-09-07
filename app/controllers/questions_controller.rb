class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index create new]
  before_action :find_question, only: %i[index show create destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
  end

  def show
  end

  def new
  end

  def create
    @question=@question.create(question_params)
    render action: :show, id: @question.id
  end

  def destroy
    @question=@question.destroy
     if @question.destroyed?
      redirect_to action: :index, test_id: @question.test.id
     else
      render json: @question.errors
     end
  end

  private
  def find_question
    if @test.nil?
      @question = Question.find(params[:id])
    else
      if params[:id].nil?
        @question = @test.questions
      else
        @question=@test.questions.find(params[:id])
      end
    end
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
