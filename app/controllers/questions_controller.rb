class QuestionsController < ApplicationController

  before_action :find_test
  before_action :find_question, only: %i[destroy]
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show
    @question = @test.questions.find(params[:id])
  end

  def new
  end

  def create
    @question=@test.questions.create(question_params)
    redirect_to "/tests/"+"#{@test.id}"+"/questions/"+"#{@question.id}", id: params[:test_id]
  end

  def search
    result=["Class: #{params.class}",
            "Parameters: #{params.inspect}"]
    render plain: result.join("\n")
  end


  def destroy
    question=@question.destroy
    if question.destroyed?
      redirect_to "/tests/#{@test.id}/questions"
      else
      render json: question.errors, status: :unprocessable_entity
    end
  end

  private
  def find_question
    find_test
    @question=@test.questions.find(params[:id])
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
  end

end
