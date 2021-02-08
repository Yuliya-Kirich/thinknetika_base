class AddDefaultChangeToTestsAndAnswers < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:tests, :level, 1)
    change_column_default(:answers, :correct, 1)
  end
end
