module AnswersHelper
  ANSWERS_FSM = %w[Новый Редактировать]
  def answer_header(answer)
    content_tag(:div, content_tag(:h1, "#{answers_fsm(answer)} ответ на вопрос: #{answer.question.body}"),
                class: 'strong')
  end

  private

  def answers_fsm(answer)
    if answer.persisted?
      ANSWERS_FSM[1]
    else
      ANSWERS_FSM[0]
    end
  end
end
