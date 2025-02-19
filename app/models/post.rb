class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image  

  validates :title, presence: true
  validates :sub, presence: true
  validates :date, presence: true
  validates :content, presence: true  
  validates :likeNum, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def as_json(options = {})
    super(options).merge({
      image_url: image.attached? ? Rails.application.routes.url_helpers.url_for(image) : nil,
      username: user.username 
    })
  end
end
