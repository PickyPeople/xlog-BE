puts "기존 데이터 삭제 시작..."

# 삭제 순서 중요: 외래 키 제약 조건 때문에 Post를 먼저 삭제
Post.destroy_all
puts "게시물 삭제 완료"

User.destroy_all
puts "사용자 삭제 완료"

puts "새로운 데이터 생성 시작..."

# 테스트 사용자 생성
user = User.create!(
  email: "test@test.com",
  password: "test1234",
  username: "PickyPeople"
)

puts "기본 사용자가 생성되었습니다!"
puts "Email: #{user.email}"
puts "Password: test1234"
puts "Username: #{user.username}"