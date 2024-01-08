class Admin::TestsController < Admin::BaseController
  # before_action :find_test
  before_action :find_test, only: %i[show destroy start edit update]
  # before_action :users_spoof_check, only: %i[show destroy start edit update]

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
    # @questions = @test.questions
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
    # @test = Test.find(params[:id])
    @categories = Category.group(:number)
    # @test.user_id = current_user.id
  end

  def update
    @categories = Category.group(:number)
    if @test.update(test_params)
      # @test.merge(user_id: @current_user.id)
      flash[:success] = 'To-do item successfully updated!'
      redirect_to admin_test_path(@test)
      # render @test, notice: 'Test was successfully updated!'
    else
      flash.now[:error] = 'To-do item update failed'
      render :edit
      # render plain: 'Такdjgdljlkjgldjljdfjgldт'
      # puts @test.errors.full_messages
      # render :edit, alert: 'Test was not successfully updated.'
    end
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id).merge(user_id: current_user.id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: 'Такого теста нет'
  end

  def users_spoof_check
    return if current_user.admin?

    redirect_to root_url unless current_user.id == @test.user_id
  end
end
