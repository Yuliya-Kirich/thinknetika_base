class QuestionsController < ApplicationController

  before_action :find_question, only: %i[show]
  before_action :find_test, only: %i[show]
  #after_action :find_test
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    # result = ["Class: #{params.class}",
    #    "Parameters: #{params.inspect}"]
    #  render plain: result.join("\n")
    @questions=Question.all
    # render json: {questions: Question.all}
  end

  def show
    #@question=Question.find(params[:id])
    #controller_name
    # action_name
    #render inline: "<%=@question.body%>"
    #render inline: "<%=@test.title%>"
    if @test.blank?
      render plain: 'В данном тесте еще нет вопросов'
    end
  end

  def new
  end

  def create
    #result=["Class: #{params.class}",
    #        "Parameters: #{params.inspect}"]
    #   render plain: result.join("\n")
    question = Question.create(question_params)
    result=["#{question.inspect}, #{question.body}"]
    if question.persisted?
      # redirect_to 'questions/'+"#{:id}"
      render plain: result.join("\n")
      #render plain: question.inspect, json: question.body , status: :created
    else
      render json: question.errors, status: :unprocessable_entity
    end
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
    @question=Question.find(params[:id])

  end

  def find_test
    #@question=Question.first

    @test=Test.where(id: @question.test_id).first
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
    params.require(:question).permit(:body, :test_id)
  end

end
