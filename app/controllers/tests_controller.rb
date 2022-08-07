class TestsController < ApplicationController

  #protect_from_forgery with: :exception
  before_action :find_test, only: %i[show]
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index

    #result = ["Class: #{params.class}",
    #"Parameters: #{params.inspect}"]
    # render plain: result.join("\n")

    # render json:{tests: Test.all}

    # logger.info(self.object_id)
    @tests=Test.all
    end

  #def show
  # redirect_to root_path
  #end

  def new
    #controller_name
    #action_name
  end

  def create
    #result=["Class: #{params.class}", "Parameters: #{params.inspect}"]
    #render plain: result.join("\n")
    #test = Test.create(test_params).update(user_id: 1, category_id: 5)


    @test = Test.new(user_id: 1, category_id: 5)
    @test.update(test_params)


    #byebug
    #test = Test.create(params(:test))


    #render plain: test.inspect


    redirect_to "/tests/"+"#{@test.id}"
    #render '/tests/:id'
  end

  def show
    #render inline: "<%=@test.title%>"
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
    #result=["Class: #{params.class}",
    #    "Parameters: #{params.inspect}"]
    # render plain: result.join("\n")
    #if @test.title != nil
    #  render plain: result.join("\n")
      #render pla
    #else
    #  render json: @test.errors, status: :unprocessable_entity
    #end
    # render text: "<%=@test.questions%>"
    # render text: "<%=@test.questions%>"
    #render text: "<%  Test.where(id: params[:id]).questions %> "
    # result = ["Class: #{params.class}",
    #      "Parameters: #{params.inspect}"]
    #render plain: result.join("\n")
    # @test=Test.find(params[:id])
    #render inline: "<%=@test.title%>"
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
  # render html:'<h1>All tests</h1>'.html_safe

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
