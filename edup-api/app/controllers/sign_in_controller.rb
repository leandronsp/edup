class SignInController < ApplicationController
  rescue_from AuthService::InvalidCredentials, with: :not_found_error

  def create
    email, password = signin_params.values_at(:email, :password)
    token, user = AuthService.authenticate(email, password)

    render json: { token: token, email: user.email, id: user.id }, status: 201
  end

  private

  def signin_params
    params.permit(:email, :password)
  end

  def not_found_error(error)
    render json: { message: error.message }, status: 404
  end
end
