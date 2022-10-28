class TestsController < ApplicationController


  before_action :find_test, only: %i[show destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  skip_before_action :verify_authenticity_token

  def index
    @test = Test.order(params[:sort])
  end

  def new
    @test = Test.new(:user_id=>1)
    @categories = Category.group(:number)
  end

  def create
    @categories = Category.group(:number)
    author = User.first
    @test = author.authored_tests.build(test_params)
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
    @test = @test.destroy
    redirect_to tests_path
  end

  def edit
    @categories = Category.group(:number)
  end

  def update
    @categories = Category.group(:number)
    if @test.update(test_params)
      redirect_to @test
    else
      render action: 'edit'
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

end

