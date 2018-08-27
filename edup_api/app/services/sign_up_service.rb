class SignUpService
  class AlreadyRegisteredError < StandardError
  end

  def register(email, password, password_confirmation)
    if user = User.find_by(email: email)
      raise AlreadyRegisteredError
    end

    User.create(email: email, password: password, password_confirmation: password_confirmation)
  end
end
