class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :roles

  def has_role?(role_name)
    roles.map(&:name).include?(role_name)
  end

  def student?
    has_role?('student')
  end

  def publisher?
    has_role?('publisher')
  end
end
