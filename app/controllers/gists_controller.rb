# frozen_string_literal: true

class GistsController < ApplicationController
  before_action :set_test_passage

  def create
    service = GistQuestionService.new(@test_passage.current_question)
    service.call
    last_response = service.last_response
    if service.success?
      @gist = Gist.new question_id: @test_passage.current_question.id,
                       test_passage_id: @test_passage.id,
                       user_id: current_user.id,
                       gist_url: last_response.data[:html_url]
      flash[:notice] = if @gist.save
                         t('test_passages.gists.success', url: last_response.data[:html_url])
                       else
                         t('test_passages.gists.failure')
                       end
    else
      flash[:alert] = t('.failure')
    end
    redirect_to @test_passage
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end
end
