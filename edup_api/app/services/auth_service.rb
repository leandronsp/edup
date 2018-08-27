class AuthService
  include Callable

  class InvalidToken < StandardError
    def to_s; 'Invalid token'; end
  end
  class InvalidCredentials < StandardError
    def to_s; 'Invalid credentials'; end
  end

  def authenticate(email, password)
    user = User.find_by(email: email)
    raise InvalidCredentials if user.blank? || !user.authenticate(password)

    JWTUtils.encode({ user_id: user.id })
  end

  def roles_for(token)
    data = JWTUtils.decode(token)
    user = User.find(data['user_id'])

    user.roles
  rescue ActiveRecord::RecordNotFound
    raise InvalidToken
  end
end
