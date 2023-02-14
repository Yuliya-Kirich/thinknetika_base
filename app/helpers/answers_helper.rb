module AnswersHelper
  def answer_header(answer)
    content_tag(:div, content_tag(:h1, "#{answers_fsm(answer)} ответ на вопрос: #{answer.question.body}"),
                class: 'strong')
  end

  private

  def answers_fsm(answer)
    if answer.persisted?
      'Редактировать'
    else
      'Новый'
    end
  end
end
