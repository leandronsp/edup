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
end
