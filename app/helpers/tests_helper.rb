module TestsHelper
  TEST_LEVELS = ['Легкий', 'Средне-легкий', 'Средний', 'Средне-сложный', 'Сложный', 'Очень сложный'].freeze

  def test_level(test)
    TEST_LEVELS.fetch(test.level, 'В процессе создания')
  end
end
