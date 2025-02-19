class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  def as_json(options = {})
    json = super(options)
    json.merge!({
      image_url: image.attached? ? Rails.application.routes.url_helpers.url_for(image) : nil,
      username: user&.username || '',
      tags: []  # 기본값으로 빈 배열 설정
    })

    # tags 관계가 존재하는 경우에만 pluck 실행
    begin
      json[:tags] = tags.pluck(:name) if self.respond_to?(:tags)
    rescue => e
      Rails.logger.error("태그 정보 가져오기 실패: #{e.message}")
    end

    json
  end
end