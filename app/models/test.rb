class Test < ApplicationRecord
  has_many :users_session, :question
  belongs_to :category, foreign_key: true

  def self.search_to_categories_title(type_of_category)
    Test.joins('JOIN categories on tests.category_id=categories.id')
        .where('type_of_category=?' , type_of_category)
        .order('title DESC').pluck(:title)
  end
end
