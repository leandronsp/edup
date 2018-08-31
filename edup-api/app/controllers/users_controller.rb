class UsersController < ApplicationController
  rescue_from SignUpService::AlreadyRegisteredError, with: :conflict_error
  rescue_from SignUpService::PasswordNotMatch, with: :conflict_error

  include Authorizable
  before_action :ensure_user_is_publisher

  def create
    user = SignUpService.register(user_params[:email], 'pa$$w0rd', 'pa$$w0rd')
    render json: user, status: 201, location: user_url(user)
  end

  def index
    render json: (User.all.map do |user|
      roles = user.roles.map(&:name)
      user.as_json.merge(roles: roles)
    end)
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def conflict_error(error)
    render json: { message: error.message }, status: 409
  end
end
