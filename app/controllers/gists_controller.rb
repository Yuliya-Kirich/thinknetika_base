# frozen_string_literal: true

class GistsController < ApplicationController
  before_action :set_test_passage

  def create
    @result = GistQuestionService.new(@test_passage.current_question).call
    if !@result.nil?
      @gist = Gist.new question_id: @test_passage.current_question.id,
                       test_passage_id: @test_passage.id,
                       user_id: current_user.id,
                       gist_url: @result.url.to_s
      flash[:notice] = if @gist.save
                         t('test_passages.gists.success', url: @result.url.to_s)
                       else
                         t('test_passages.gists.failure', url: @result&.url.to_s)
                       end
    else
      flash[:alert] = t('.failure', url: @result&.url.to_s)
    end

    redirect_to @test_passage
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
