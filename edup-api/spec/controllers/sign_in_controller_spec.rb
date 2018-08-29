describe SignInController, type: :controller do
  let(:user) { build_user }
  before { user.save }

  describe 'POST /signin' do
    it 'performs a new signin and returns a JWT' do
      post :create, params: { email: 'email@example.com', password: '111' }
      expect(response.code).to eq('201')

      token = JSON.parse(response.body)['token']
      data = JWTUtils.decode(token)
      expect(data['user_id']).to eq(user.id)
    end

    it 'returns 404 when invalid credentials' do
      post :create, params: { email: 'email@example.com', password: 'invalid' }
      expect(response.code).to eq('404')
    end
  end
end
