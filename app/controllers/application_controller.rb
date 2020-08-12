class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include CanCan::ControllerAdditions

  respond_to :json
  before_action :authenticate_user

  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: exception.message }, status: 403
  end

  private

  #
  # authenticate_user!
  #
  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  #
  # current_user
  #
  def current_user
    @current_user ||= User.find(@current_user_id)
  end

  #
  # signed_in?
  #
  def signed_in?
    @current_user_id.present?
  end

  #
  # authenticate_user
  #
  def authenticate_user
    if request.headers['Authorization'].present?

      authenticate_or_request_with_http_token do |token, options|

        begin
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

          @current_user_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end
end
