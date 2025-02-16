# 課題
Ruby on RailsとVue.jsを用いたブログプラットフォームを構築していただきます。

# **課題の説明**
1. ブログ記事の管理
<ul>
 <li>記事の投稿、編集、削除機能をRailsで実装。</li>
 <li>記事にカテゴリやタグを関連付けるリレーションを構築。</li>
</ul>

2.検索・フィルタリング機能
<ul>
 <li>Vue.jsを用いて、記事をカテゴリごとにフィルタリングし、検索できる機能を実装。</li>
</ul>

3.ユーザー認証機能
<ul>
 <li>Railsで簡易的なログイン/ログアウト機能を追加。</li>
</ul>

4.レスポンシブデザイン
<ul>
 <li>フロントエンドでモバイル対応のデザインを適用。</li>
</ul>

5.任意項目（追加要素）
<ul>
 <li>単体テストまたはE2Eテストを導入。</li>
 <li>デプロイ手順のドキュメント化。</li>
</ul>

# **フォルダーの仕組み**
# **ログインとログアウト通信**
### Userモデル生成
```bash
 # User モデル生成コマンド
rails generate model User email:string password_digest:string
```
<ul>
 <li>app/models/user.rb: Userモデルファイル生成</li>
 <li>db/migrate/YYYYMMDDHHMMSS_create_users.rb: データベース マイグレーションファイル生成</li>
</ul>

### Userモデル設定(app/models/user.rb)
```ruby
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
end
```
<ul>
 <li>presenceで必ず入力するようにし、uniquenessで重複ができないようにします。</li>
</ul>

### データベース マイグレーション実行
```bash
rails db:migrate
```
<ul>
 <li>rails db:migrateでテーブルを作ります。</li>
</ul>

### auth_controllers 生成(app/controllers/api)
```ruby
module Api
  class AuthController < ApplicationController
    def login
      user = User.find_by(email: params[:email])
      
      if user&.authenticate(params[:password])
        render json: { status: 'success' }
      else
        render json: { status: 'error', message: '로그인 실패' }, status: :unauthorized
      end
    end

    def logout
      render json: { status: 'success' }
    end
  end
end
```
### user.rb(app/model/user.rb)
```ruby
class User < ApplicationRecord
  has_secure_password #비밀번호를 암호화 하기 위한 메서드 ex)test1234 => 324kjdkjdas이렇게 암호화가 된다.
  validates :email, presence: true, uniqueness: true #이메일 유효성 검사 presence는 required, uniqueness는 중복이 될 수 없다는 뜻
end
```
1. フロントから貰った要請を送ります。
2. AuthController Classが要請が要請をもらいます。
3. Userモデルで使用者を探します。
4. Userモデルでhas_secure_passwordを通じてパスワードを確認します。
5. 確認結果をAuthControllerがもらい、JSONの形でvueに伝えます。
### ラウト設定(config/routes.rb)
```ruby
Rails.application.routes.draw do
  namespace :api do
    post '/login', to: 'auth#login'
    post '/logout', to: 'auth#logout'
  end
end
```
### テスト使用者生成
```bash
rails console

User.create(email: "jjyjjh33@gmail.com", password: "jjy991019")
```
