class SignUpController < ApplicationController

  def create
    email, password, password_confirmation = signup_params.values_at(
      :email, :password, :password_confirmation)

    @current_user = signup_service.register(email, password, password_confirmation)
    head :created
  end

  private

  def signup_service
    SignUpService.new
  end

  def signup_params
    params.permit(:email, :password, :password_confirmation)
  end
end
