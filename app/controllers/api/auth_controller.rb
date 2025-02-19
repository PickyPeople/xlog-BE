module Api
  class AuthController < ApplicationController
    def login
      user = User.find_by(email: params[:email])
      
      if user&.authenticate(params[:password])
        token = JWT.encode(
          { user_id: user.id, exp: 24.hours.from_now.to_i },
          Rails.application.credentials.secret_key_base
        )
        render json: { 
          status: 'success',
          token: token,
          user: { email: user.email }
        }
      else
        render json: { 
          status: 'error', 
          message: '로그인 실패' 
        }, status: :unauthorized
      end
    end

    def logout
      render json: { status: 'success' }
    end

    def me
      authenticate_token
      if @current_user
        render json: {
          status: 'success',
          user: { email: @current_user.email, username: @current_user.username }
        }
      end
    end
  end
end