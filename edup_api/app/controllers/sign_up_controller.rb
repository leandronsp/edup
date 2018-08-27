class SignUpController < ApplicationController
  rescue_from SignUpService::AlreadyRegisteredError, with: :conflict_error
  rescue_from SignUpService::PasswordNotMatch, with: :conflict_error

  def create
    email, password, password_confirmation = signup_params.values_at(
      :email, :password, :password_confirmation)

    signup_service.register(email, password, password_confirmation)
    head :created
  end

  private

  def signup_service
    SignUpService.new
  end

  def signup_params
    params.permit(:email, :password, :password_confirmation)
  end

  def conflict_error(error)
    render json: { message: error.message }, status: 409
  end
end
