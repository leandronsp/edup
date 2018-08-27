describe CoursesController, type: :controller do
  let(:publisher) { User.create(email: 'publisher@example.com', password: '111', password_confirmation: '111') }

  before do
    token = JWTUtils.encode({ user_id: publisher.id })
    request.headers['Authorization'] = token
  end

  describe 'POST /courses' do
    it 'creates a new course' do
      post :create, params: { course: { name: 'Ruby programming' }}

      expect(response.code).to eq('201')

      created = Course.last
      expect(response.location).to eq("http://test.host/courses/#{created.id}")
    end

    it 'returns 403 Forbidden when missing JWT' do
      request.headers['Authorization'] = nil

      post :create, params: { course: { name: 'Ruby programming' }}
      expect(response.code).to eq('403')
    end

    it 'returns 403 Forbidden for invalid JWT' do
      request.headers['Authorization'] = JWTUtils.encode({})

      post :create, params: { course: { name: 'Ruby programming' }}
      expect(response.code).to eq('403')
    end
  end
end
