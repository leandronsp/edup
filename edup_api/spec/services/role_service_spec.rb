describe RoleService do
  describe '#create_role' do
    it 'creates a new role' do
      role = subject.create_role('student')
      expect(role.name).to eq('student')
    end

    it 'does not duplicate the role' do
      role_a = subject.create_role('student')
      role_b = subject.create_role('student')

      expect(role_a.reload.id).to eq(role_b.reload.id)
    end
  end

  describe '#delete_role' do
    it 'deletes a role' do
      role = subject.create_role('student')
      subject.delete_role(role)

      expect { role.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#attach' do
    it 'attaches a role for a given user' do
      user = User.create(email: 'email@example.com', password: '111', password_confirmation: '111')
      expect(user.roles.size).to eq(0)

      role = subject.create_role('publisher')
      subject.attach(role, user)

      expect(user.reload.roles[0].name).to eq('publisher')
    end
  end

  describe '#detach' do
    it 'detaches a role for a given user' do
      user = User.create(email: 'email@example.com', password: '111', password_confirmation: '111')
      role = subject.create_role('publisher')
      subject.attach(role, user)

      expect(user.reload.roles.size).to eq(1)
      subject.detach(role, user)

      expect(user.reload.roles.size).to eq(0)
    end

    it 'detaches a role for a given user and keeps the other roles' do
      user = User.create(email: 'email@example.com', password: '111', password_confirmation: '111')
      subject.attach(subject.create_role('publisher'), user)
      subject.attach(subject.create_role('student'), user)

      expect(user.reload.roles.size).to eq(2)
      subject.detach(Role.find_by(name: 'publisher'), user)

      expect(user.reload.roles.size).to eq(1)
      expect(user.reload.roles[0].name).to eq('student')
    end
  end
end