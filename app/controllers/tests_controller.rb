class TestsController < ApplicationController

  before_action :find_test, only: %i[show]
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests=Test.all
    end

  def new
  end

  def create
    @test = Test.new(user_id: 1, category_id: 5)
    @test.update(test_params)
    redirect_to "/tests/"+"#{@test.id}"
  end

  def show
  end

  def destroy
    test=Test.where(id: params[:id]).first.destroy
  if test.destroyed?
    redirect_to '/tests'
  else
    render json: tests.errors, status: :unprocessable_entity
  end
  end

  def search_all_questions
    if @test.questions.blank?
      render plain: 'В данном тесте еще нет вопросов'
    end
  end


  private

  def  test_params
    params.require(:test).permit(:title, :level)
  end

  def search
    result=["Class: #{params.class}",
            "Parameters: #{params.inspect}"]
    render plain: result.join("\n")
  end


  def find_test
    @test=Test.find(params[:id])
  end

   def send_log_message
     logger.info("Action [#{action_name}] was finished")
   end

   def rescue_with_test_not_found
     render plain: 'Такого теста нет'
   end

  def log_execute_time
    start=Time.now
    yield
    finish=Time.now-start
    logger.info("Execution time: #{finish * 1000} ms")
  end
end
