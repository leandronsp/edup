class AuthService
  def authenticate(email, password)
    user = User.find_by_email(email)
    return nil unless user
    return nil unless user.authenticate(password)

    JWTUtils.encode({ user_id: user.id })
  end
end
