module JsonWebToken
  extend ActiveSupport::Concern

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
  rescue JWT::DecodeError
    nil
  end

  def authenticate_token
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    
    begin
      decoded = decode_token(token)
      @current_user = User.find(decoded['user_id'])
    rescue JWT::ExpiredSignature
      render json: { error: '토큰이 만료되었습니다' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: '유효하지 않은 토큰입니다' }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { error: '사용자를 찾을 수 없습니다' }, status: :unauthorized
    end
  end
end