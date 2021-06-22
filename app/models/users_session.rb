class UsersSession  < ApplicationRecord
  belongs_to :test, :user, foreign_key: true
end