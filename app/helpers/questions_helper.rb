module QuestionsHelper
  def question_header
    content_tag(:div, content_tag(:h1,  "#{t action_name} вопрос для теста: #{@test.title} "), class: "strong")
  end
end