class Test < ApplicationRecord
  has_many :users_sessions
  has_many :users, through: :users_sessions
  has_many :questions
  belongs_to :author, foreign_key: :user_id, class_name: 'User'
  belongs_to :category

  n = Float::INFINITY

  validates :title, presence: true

  validates :level, numericality: { only_integer: true },
                    presence: true

   #Может существовать только один Тест с данным названием и уровнем
  validate :validate_test_case_sensitive, on: :create



  scope :easy, -> {where(level:0..1).order(created_at: :asc)}
  scope :middle, -> {where(level:2..4).order(created_at: :asc)}
  scope :difficult, -> {where(level:5..n).order(created_at: :asc)}
  scope :selection_name_category, ->(type_of_category) {joins(:category)
                                                          .where('type_of_category=?', type_of_category)
                                                          .order('title DESC')
                                                          .pluck(:title)}
  scope :test_set, -> {Test.select(:title, :level)}


  private
  def validate_test_case_sensitive
    errors.add(:title) if Test.where("level==? AND title==?", level, title) != []
  end

end
