class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image  # Active Storage 설정

  validates :title, presence: true
  validates :sub, presence: true
  validates :date, presence: true
  validates :content, presence: true  # content 필드 검증 추가
  validates :likeNum, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def as_json(options = {})
    super(options).merge({
      image_url: image.attached? ? Rails.application.routes.url_helpers.url_for(image) : nil,
      username: user.username # 사용자 이름도 함께 포함
    })
  end
end
