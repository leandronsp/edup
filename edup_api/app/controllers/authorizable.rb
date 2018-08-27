module Authorizable
  extend ActiveSupport::Concern

  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from Authorizable::MissingToken, with: :forbidden_error
    rescue_from Authorizable::InvalidToken, with: :forbidden_error
    before_action :check_authorization

    def forbidden_error
      render status: 403
    end
  end

  def check_authorization
    raise MissingToken if request.headers['Authorization'].blank?

    token = request.headers['Authorization']
    data = JWTUtils.decode(token)
    user = User.find(data['user_id']) if data['user_id']

    raise InvalidToken if user.blank?
  end
end
