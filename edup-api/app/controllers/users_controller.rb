class UsersController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher

  def index
    render json: User.all
  end
end
