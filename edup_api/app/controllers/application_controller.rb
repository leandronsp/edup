class ApplicationController < ActionController::API
  rescue_from SignUpService::AlreadyRegisteredError, with: :error_conflict
  rescue_from SignUpService::PasswordNotMatch, with: :error_conflict

  def error_conflict(error)
    render json: { message: error.message }, status: 409
  end

  def current_user
    @current_user
  end
end
