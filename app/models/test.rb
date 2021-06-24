class Test < ApplicationRecord
  has_and_belongs_to_many :user
  has_many :question
  belongs_to :category

  def self.search_to_categories_title(type_of_category)
    Test.joins('JOIN categories on tests.category_id=categories.id')
        .where('type_of_category=?' , type_of_category)
        .order('title DESC').pluck(:title)
  end
end
