describe UsersController, type: :controller do
  before do
    authenticate_as_publisher
  end

  describe 'GET /users' do
    it 'retrieves all users' do
      build_user

      get :index
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body).size).to eq(2)
      expect(JSON.parse(response.body)[0]['roles']).to eq(['publisher'])
    end
  end

  describe 'POST /users' do
    it 'creates a new user' do
      post :create, params: { user: { email: 'new@example.com' }}

      expect(response.code).to eq('201')

      created = User.find_by(email: 'new@example.com')
      expect(response.location).to eq("http://test.host/users/#{created.id}")
      expect(created.email).to eq('new@example.com')
    end

    it 'does not duplicate emails' do
      build_user

      post :create, params: { user: { email: 'email@example.com' }}

      expect(response.status).to eq(409)
      expect(JSON.parse(response.body)['message']).to eq('Already registered')
    end
  end
end
