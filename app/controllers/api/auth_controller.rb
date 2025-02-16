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