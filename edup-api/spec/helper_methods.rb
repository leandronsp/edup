module HelperMethods
  def build_user(params = {})
    email = params.fetch(:email, 'email@example.com')
    password = params.fetch(:password, '111')
    password_confirmation = params.fetch(:password_confirmation, '111')

    user = User.create({
      email: email,
      password: password,
      password_confirmation: password_confirmation
    })

    if role_name = params[:role]
      role = RoleService.create_role(role_name)
      RoleService.attach(role, user)
    end

    user
  end

  def build_publisher(params = {})
    build_user(email: 'publisher@example.com', role: 'publisher')
  end

  def build_student(params = {})
    build_user(email: 'student@example.com', role: 'student')
  end

  def publisher_token
    JWTUtils.encode({ user_id: build_publisher.id })
  end

  def student_token
    JWTUtils.encode({ user_id: build_student.id })
  end

  def invalid_token
    JWTUtils.encode({})
  end

  def authenticate_as_publisher
    set_request_token(publisher_token)
  end

  def authenticate_as_student
    set_request_token(student_token)
  end

  def set_request_token(token)
    request.headers['Authorization'] = "Bearer #{token}"
  end
end
