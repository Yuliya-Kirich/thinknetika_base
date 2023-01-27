module AnswersHelper
  def answer_header(question, answer)
    content_tag(:div, content_tag(:h1, "#{t action_name} ответ на вопрос: #{if question.blank?
                                                                              answer.question.body
                                                                             else
                                                                               question.body
                                                                             end}"), class: "strong")
  end
end
