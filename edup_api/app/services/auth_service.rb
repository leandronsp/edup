class AuthService
  def authenticate(email, password)
    user = User.find_by(email: email)
    return nil unless user
    return nil unless user.authenticate(password)

    JWTUtils.encode({ user_id: user.id })
  end

  def roles_for(token)
    data = JWTUtils.decode(token)
    user = User.find(data['user_id'])
    user.roles
  end
end
