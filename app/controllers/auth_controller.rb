class AuthController < ApplicationController
  
  # 상수는 메소드 밖에서 정의
  VALID_EMAIL = "test@test.com"
  VALID_PASSWORD = "password123"

  def login
    if params[:email] == VALID_EMAIL && params[:password] == VALID_PASSWORD
      render json: { status: 'success', message: '로그인 성공' }
    else
      render json: { status: 'error', message: '이메일 또는 비밀번호가 잘못되었습니다' }, 
             status: :unauthorized
    end
  end
end
