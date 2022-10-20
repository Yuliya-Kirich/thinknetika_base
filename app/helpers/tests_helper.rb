module TestsHelper
  TEST_LEVELS={0=>"Легкий", 1=>"Средне-легкий", 3=>"Средний", 4=>"Средне-сложный", 5=>"Сложный", 6=>"Очень сложный"}.freeze
  def test_level(test)
    TEST_LEVELS[test.level] || "В процессе создания"
  end
end

