class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index create new]
  before_action :find_question, only: %i[show destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show
    #@test= @question.test
  end

  def new
    @question=Question.new
  end

  def create
    @question=@test.questions.new(question_params)
    if @question.save
      redirect_to action: :show, id: @question.id
    else
      render :new
    end
  end

  def edit
    @test= @question.test
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render action: edit
    end
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
