module TestPassagesHelper
  def test_passage_message(test_passage)
    rate = @test_passage.correct_questions*100/@test_passage.test.questions.count
    color_sensor = (rate >= 85)
    content_tag(:div, content_tag(:p, if rate >= 85
                      "#{rate}% - Тест пройден успешно!"
                    else
                      "#{rate}% - Тест не пройден!"
                                      end, class: "test-result-#{color_sensor}"), class: "test-result-#{color_sensor}")
  end

end
