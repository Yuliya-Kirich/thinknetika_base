module TestPassagesHelper
  def test_passage_message_helper(test_passage)
    result = test_passage.success?
    rate = test_passage.correct_questions_rate
    content_tag(:div, content_tag(:p, if result
                                        "#{rate}% - Тест пройден успешно!"
                                      else
                                        "#{rate}% - Тест не пройден!"
                                      end, class: "test-result-#{result}"),
                class: "test-result-#{result}")
  end
end
