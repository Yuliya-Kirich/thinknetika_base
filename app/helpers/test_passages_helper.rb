module TestPassagesHelper
  def test_passage_message_helper(test_passage)
    content_tag(:div, content_tag(:p, if test_passage.success?
                                        "#{test_passage.correct_questions_rate}% - Тест пройден успешно!"
                                      else
                                        "#{test_passage.correct_questions_rate}% - Тест не пройден!"
                                      end, class: "test-result-#{test_passage.success?}"),
                class: "test-result-#{test_passage.success?}")
  end
end
