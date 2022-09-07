class TestsController < ApplicationController

  before_action :find_test, only: %i[index show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  skip_before_action :verify_authenticity_token

  def index
  end

  def new
  end

  def create
    @test = Test.new(user_id: 1, category_id: 5)
    @test.update(test_params)
    redirect_to action: :show, id: @test.id
  end

  def show
  end

  def destroy
    @test=@test.destroy
   if @test.destroyed?
     redirect_to action: :index
   else
     render json: tests.errors
   end
  end

  private

  def test_params
    params.require(:test).permit(:title, :level)
  end

  def search
  end

  def find_test
    if params[:id].nil?
      @test=Test.all
    else
      @test=Test.find(params[:id])
    end
  end

   def rescue_with_test_not_found
     render plain: 'Такого теста нет'
   end

end
