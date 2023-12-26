class Admin::TestsController < Admin::BaseController
  before_action :find_test, only: %i[show destroy edit update start]
  before_action :users_spoof_check, only: %i[show destroy start edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @test = Test.all
  end

  def new
    @test = current_user.authored_tests.new
    @categories = Category.group(:number)
  end

  def create
    @categories = Category.group(:number)
    @test = current_user.authored_tests.build(test_params.merge(user_id: current_user.id))

    if @test.save

      redirect_to admin_test_url(@test), notice: t('.success')
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
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  def edit
    @categories = Category.group(:number)
  end

  def update
    @categories = Category.group(:number)
    if @test.update(test_params)
      redirect_to admin_test_url(@test)
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
    redirect_to root_url unless current_user.id == @test.user_id
  end
end
