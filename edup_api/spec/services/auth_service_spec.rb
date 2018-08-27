describe AuthService do
  describe '#authenticate' do
    let(:user) do
      User.create(email: 'email@example.com', password: '111', password_confirmation: '111')
    end

    before { user.save }

    it 'authenticates valid credentials and returns a JWT' do
      token = subject.authenticate('email@example.com', '111')

      body = JWT.decode(token, nil, false)[0]
      expect(body['user_id']).to eq(user.id)
    end

    it 'does not authenticate email not found' do
      expect(subject.authenticate('wrong@email.com', '111')).to eq(nil)
    end

    it 'does not authenticate wrong password' do
      expect(subject.authenticate('email@example.com', 'wrong')).to eq(nil)
    end
  end
end
