class ApplicationController < ActionController::API
  include JsonWebToken

  private

  def authenticate_user
    authenticate_token
  end

  def current_user
    @current_user
  end
end