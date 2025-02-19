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

# 게시물 데이터 생성
posts_data = [
  {
    title: "첫 게시물",
    sub: "첫 게시물에 대한 설명입니다.지금부터 몇자까지 늘어나는지 테스트를 위해서 한번 길게 써볼까 합니다 같이 테스트를 하면 재미있을 것 같으니 참여를 부탁드립니다.",
    img: "../images/postImg.png",
    date: "2025-02-03",
    likeNum: 4
  },
  {
    title: "두 번째 게시물",
    sub: "두번째 게시물에 대한 설명입니다.",
    img: "../images/postImg.png",
    date: "2025-02-03",
    likeNum: 4
  },
  {
    title: "세 번째 게시물",
    sub: "세번째 게시물에 대한 설명입니다.",
    img: "/images/postImg.png",
    date: "2025-02-03",
    likeNum: 4
  }
]

# 게시물 생성
posts_data.each do |post_data|
  post = user.posts.create!(
    title: post_data[:title],
    sub: post_data[:sub],
    img: post_data[:img],
    date: Date.parse(post_data[:date]),
    likeNum: post_data[:likeNum]
  )
  puts "게시물 생성됨: #{post.title}"
end

puts "샘플 데이터 생성이 완료되었습니다!"
puts "생성된 게시물 수: #{Post.count}"