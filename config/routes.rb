
Rails.application.routes.draw do
  namespace :api do
    # 인증 관련 라우트
    post '/login', to: 'auth#login'
    post '/logout', to: 'auth#logout'
    get '/me', to: 'auth#me'

    # posts 관련 라우트 
    resources :posts do
      collection do
        get 'search'
      end
    end
  end
end