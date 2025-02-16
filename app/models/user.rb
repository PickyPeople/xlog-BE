class User < ApplicationRecord
  has_secure_password #비밀번호를 암호화 하기 위한 메서드 ex)test1234 => 324kjdkjdas이렇게 암호화가 된다.
  validates :email, presence: true, uniqueness: true #이메일 유효성 검사 presence는 required, uniqueness는 중복이 될 수 없다는 뜻
end
