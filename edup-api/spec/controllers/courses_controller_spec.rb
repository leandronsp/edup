describe CoursesController, type: :controller do
  before do
    authenticate_as_publisher
  end

  describe 'POST /courses' do
    it 'creates a new course' do
      post :create, params: { course: { name: 'Ruby programming' }}

      expect(response.code).to eq('201')

      created = Course.last
      expect(response.location).to eq("http://test.host/courses/#{created.id}")
    end
  end

  describe 'GET /courses' do
    it 'retrieves all courses' do
      course = PublisherService.create_course('Ruby programming')

      get :index
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)[0]['name']).to eq('Ruby programming')
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
