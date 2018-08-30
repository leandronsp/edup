describe AuthService do
  describe '#authenticate' do
    let(:user) { build_user }
    before { user.save }

    it 'authenticates valid credentials and returns a JWT and user' do
      token, authenticated_user = described_class.authenticate('email@example.com', '111')

      data = JWTUtils.decode(token)
      expect(data['user_id']).to eq(user.id)
      expect(authenticated_user.id).to eq(user.id)
    end

    it 'does not authenticate email not found' do
      expect { described_class.authenticate('wrong@email.com', '222') }
        .to raise_error(AuthService::InvalidCredentials)
    end

    it 'does not authenticate wrong password' do
      expect { described_class.authenticate('example@email.com', 'wrong') }
        .to raise_error(AuthService::InvalidCredentials)
    end
  end

  describe '#roles_for' do
    let(:user) do
      User.create(email: 'email@example.com', password: '111', password_confirmation: '111')
    end

    before do
      role = RoleService.new.create_role('student')
      RoleService.new.attach(role, user)
    end

    it 'retrieves roles for a given JWT' do
      token = JWTUtils.encode({ user_id: user.id })
      roles = described_class.roles_for(token)

      expect(roles.size).to eq(1)
    end

    it 'raises an error when user does not exist' do
      token = JWTUtils.encode({ user_id: 'wrong id' })
      expect { described_class.roles_for(token) }.to raise_error(AuthService::InvalidToken)
    end
  end
end
