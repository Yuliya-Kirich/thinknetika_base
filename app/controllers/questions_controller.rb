class QuestionsController < ApplicationController

  #before_action :find_question, only: %i[show]
  before_action :find_test, only: %i[index, new, create]
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @test=Test.find(params[:test_id])
    @question = @test.questions
    # render json: {questions: Question.all}
  end

  def show
    @test = Test.find(params[:test_id])
    @question = @test.questions.find(params[:id])
  end

  def new
    # @test=Test.find(params[:id])
    #render 'tests/questions/new', test: @test
   # redirect_to "/questions/"+"#{question.id}", question: @question
    # @test=Test.find(params id: @tests.id)
    @test=Test.find(params[:test_id])

  end

  def create
    @question=@test.questions.create(question_params)
    redirect_to "/tests/"+"#{@test.id}"+"/questions/"+"#{@question.id}", id: params[:test_id]
    #@question=@test.questions.create(question_param)
    #question = Question.create(question_params)
    #result=["#{@question.inspect}, #{@question.body}"]
    #if @question.persisted?
    #   render plain: result.join("\n")
    #else
    #   render json: @question.errors, status: :unprocessable_entity
    #end

  end

  def search
    result=["Class: #{params.class}",
            "Parameters: #{params.inspect}"]
    render plain: result.join("\n")
  end


  def destroy
    question=Question.where(id: params[:id]).first.destroy
    if question.destroyed?
      redirect_to '/questions'
      else
      render json: questions.errors, status: :unprocessable_entity
    end
  end

  private
  def find_question
    @question=@test.questions
    #@question=Question.find(params[:id])

  end

  def find_test
    @test=Test.find(params[:test_id])
  end

  def log_execute_time
    start=Time.now
    yield
    finish=Time.now-start
    logger.info("Execution time: #{finish * 1000} ms")
  end

  def send_log_message
    logger.info("Action [#{action_name}] was finished")
  end

  def rescue_with_question_not_found
    render plain: 'Такого вопроса нет'
  end

  def question_params
    params.require(:question).permit(:body)
    #permit(:body)
  end

end
