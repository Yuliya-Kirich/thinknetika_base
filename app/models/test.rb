class Test < ApplicationRecord
  has_many :users_sessions
  has_many :users, through: :users_sessions
  has_many :questions
  belongs_to :author, foreign_key: :user_id, class_name: 'User'
  belongs_to :category



  validates :title, presence: true, uniqueness: true

  validates :level, numericality: { only_integer: true },
                    presence: true, uniqueness: true

  validates :level,  uniqueness: {scope: [:level, :title], message: "should have a unique level of title" }
   #Может существовать только один Тест с данным названием и уровнем



  scope :easy, -> {where(level:0..1)}
  scope :middle, -> {where(level:2..4)}
  scope :difficult, -> {where(level:5..Float::INFINITY)}
  scope :category_name, ->(type_of_category) {joins(:category)
                                                          .where('type_of_category=?', type_of_category)}
  scope :test_set, -> {select(:title, :level)}


  private

  def sort_easy
    easy.order(created_at: :asc)
  end

  def sort_middle
    middle.order(created_at: :asc)
  end

  def sort_difficult
    difficult.order(created_at: :asc)
  end

  def selection_name_category
    category_name.order('title DESC')
                 .pluck(:title)
  end
end
