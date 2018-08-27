describe SignUpService do
  describe '#register' do
    it 'registers a new user' do
      user = subject.register('email@example.com', '111', '111')
      expect(user.email).to eq('email@example.com')
    end

    it 'does not duplicate users' do
      subject.register('email@example.com', '111', '111')

      expect { subject.register('email@example.com', '222', '222') }
        .to raise_error(SignUpService::AlreadyRegisteredError)
    end

    it 'validates password match' do
      expect { subject.register('email@example.com', '111', '222') }
        .to raise_error(SignUpService::PasswordNotMatch)
    end
  end
end
