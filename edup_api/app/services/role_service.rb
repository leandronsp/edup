class RoleService
  def create_role(name)
    Role.find_or_create_by(name: name)
  end

  def delete_role(role)
    role.delete
  end
end
