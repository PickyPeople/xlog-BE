class User < ApplicationRecord
  has_many :posts, dependent: :destroy  # 사용자가 삭제되면 게시물도 함께 삭제
  has_secure_password #비밀번호를 암호화 하기 위한 메서드 ex)test1234 => 324kjdkjdas이렇게 암호화가 된다.
  validates :email, presence: true, uniqueness: true #이메일 유효성 검사 presence는 required, uniqueness는 중복이 될 수 없다는 뜻
  validates :username, presence: true, uniqueness: true  # username도 필수값으로 설정
end
