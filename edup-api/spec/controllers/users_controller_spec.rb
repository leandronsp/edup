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
    end
  end
end
