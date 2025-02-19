puts "기존 데이터 삭제 시작..."

Post.destroy_all
puts "게시물 삭제 완료"

User.destroy_all
puts "사용자 삭제 완료"

puts "새로운 데이터 생성 시작..."

# 테스트 사용자 생성
user1 = User.create!(
  email: "test@test.com",
  password: "test1234",
  username: "PickyPeople"
)

puts "기본 사용자가 생성되었습니다!"
puts "Email: #{user1.email}"
puts "Password: test1234"
puts "Username: #{user1.username}"

user2 = User.create!(
  email: "newuser@test.com",
  password: "newpassword",
  username: "NewUser"
)

puts "두 번째 사용자가 생성되었습니다!"
puts "Email: #{user2.email}"
puts "Password: newpassword"
puts "Username: #{user2.username}"