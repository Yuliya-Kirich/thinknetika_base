class TestsController < ApplicationController
  before_action :find_test, only: %i[start]
  before_action :users_spoof_check, only: %i[start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @test = current_user.authored_tests.order(params[:sort])
    redirect_to admin_tests_path if current_user.admin?
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

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
