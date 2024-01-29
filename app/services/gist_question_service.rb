# frozen_string_literal: true

class GistQuestionService
  ACCESS_TOKEN = ENV['GITHUB_TOKEN']

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || Octokit::Client.new(access_token: ACCESS_TOKEN)
  end

  def call
    @gist_client = @client.create_gist(gist_params)
  end

  def last_response
    @last_response = @client.last_response
  end

  def success?
    @last_response.status >= 200 && @last_response.status < 300
  end

  private

  def gist_params
    { description: I18n.t('gist_question_service.description', title: @question.test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      } }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
