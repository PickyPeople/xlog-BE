class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :sub, presence: true
  validates :date, presence: true
end
