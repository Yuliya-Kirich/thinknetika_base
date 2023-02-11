module AnswersHelper
  def answer_header(answer)
    content_tag(:div, content_tag(:h1, "#{t action_name} ответ на вопрос: #{answer.question.body}"),
                class: 'strong')
  end
end
