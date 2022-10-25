module QuestionsHelper
  def question_header
    content_tag(:div, content_tag(:h1,
                                  "#{t action_name} вопрос для теста:
      #{if @test.blank?
          @question.test.title
        else
          @test.title
      end} "), class: "strong")
  end
end