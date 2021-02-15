class Test < ApplicationRecord
  def self.search_to_categories_title(type_category)

    pp Test.select(:title).joins('JOIN categories on tests.category_id=categories.id').where('type_category=?' , type_category).order('title DESC')

  end
end
