class Test < ApplicationRecord
  has_many :users_sessions
  has_many :users, through: :users_sessions
  has_many :questions
  belongs_to :author, foreign_key: :user_id, class_name: 'User'
  belongs_to :category

  n = Float::INFINITY

  scope :easy, -> {where(level:0..1).order(created_at: :asc)}
  scope :middle, -> {where(level:2..4).order(created_at: :asc)}
  scope :difficult, -> {where(level:5..n).order(created_at: :asc)}

  def self.search_to_categories_title(type_of_category)
    Test.joins('JOIN categories on tests.category_id=categories.id')
        .where('type_of_category=?' , type_of_category)
        .order('title DESC').pluck(:title)
  end
end
