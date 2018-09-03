describe User, type: :model do
  let(:user) { build_user }

  it 'uses UUID as ID' do
    expect(user.id).to match(/^[\w]{8}-[\w]{4}-[\w]{4}-[\w]{4}-[\w]{12}$/)
  end

  describe '#has_role?' do
    before do
      RoleService.attach(Role.create(name: 'student'), user)
    end

    it 'checks the user role' do
      expect(user.has_role?('student')).to eq(true)
      expect(user.has_role?('admin')).to eq(false)

      expect(user.student?).to eq(true)
      expect(user.publisher?).to eq(false)
    end
  end
end
