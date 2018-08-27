describe CoursesController, type: :controller do
  before do
    publisher = User.create(email: 'publisher@example.com', password: '111', password_confirmation: '111')
    role = RoleService.create_role('publisher')
    RoleService.attach(role, publisher)

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
  end

  describe 'GET /course/:id' do
    let(:course) { PublisherService.create_course('Ruby programming') }

    it 'retrieves a course' do
      get :show, { params: { id: course.id }}
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['name']).to eq('Ruby programming')
    end

    it 'returns 404' do
      get :show, { params: { id: '111' }}
      expect(response.code).to eq('404')
    end
  end
end
