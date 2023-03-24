class TestsController < ApplicationController
  before_action :redirect_url_remember
  before_action :authenticate_user!
  before_action :find_test, only: %i[show destroy edit update start]
  before_action :users_spoof_check, only: %i[show destroy start edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  skip_before_action :verify_authenticity_token

  def index
    @test = Test.where(user_id: @current_user.id).order(params[:sort])
  end

  def new
    @test = Test.new
    @categories = Category.group(:number)
  end

  def create
    @categories = Category.group(:number)
    @test = @current_user.authored_tests.build(test_params)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def show
    @questions = @test.questions
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    @current_user.tests.push(@test)
    redirect_to @current_user.test_passage(@test)
  end

  def edit
    @categories = Category.group(:number)
  end

  def update
    @categories = Category.group(:number)
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: 'Такого теста нет'
  end

  def users_spoof_check
    find_test
    redirect_to root_url unless current_user.id == @test.user_id
  end
end
