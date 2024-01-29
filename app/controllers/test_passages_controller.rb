class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_test_passage, only: %i[show update result gist]
  before_action :set_test_passage

  before_action :users_spoof_check_for_test_passages

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def users_spoof_check_for_test_passages
    redirect_to root_url unless current_user&.id == @test_passage.test.user_id
  end
end
