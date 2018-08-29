class RoleService
  include Callable

  def create_role(name)
    Role.find_or_create_by(name: name)
  end

  def delete_role(role)
    role.delete
  end

  def attach(role, user)
    user.roles << role
  end

  def detach(role, user)
    user.roles.delete(role)
  end
end
