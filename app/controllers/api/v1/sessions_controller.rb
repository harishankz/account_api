class Api::V1::SessionsController < Devise::SessionsController
  include UserConcern

  def create
    user = User.find_by_email(params[:email])

    if user && user.valid_password?(params[:password])
      @current_user = user
      render json: {
          status: :created,
          logged_in: true,
          user: user,
          token: user.generate_jwt
      }
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end