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
### Auth controllers 生成
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
