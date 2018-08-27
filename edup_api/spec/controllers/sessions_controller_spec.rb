describe SessionsController, type: :controller do
  let(:course_a) { PublisherService.create_course('Ruby programming') }
  let(:course_b) { PublisherService.create_course('Node programming') }

  let(:courses_ids) { [course_a, course_b].map(&:id) }

  before do
    publisher = User.create(email: 'publisher@example.com', password: '111', password_confirmation: '111')
    role = RoleService.create_role('publisher')
    RoleService.attach(role, publisher)

    token = JWTUtils.encode({ user_id: publisher.id })
    request.headers['Authorization'] = token
  end

  describe 'POST /sessions' do
    it 'creates a session based on a set of courses' do
      post :create, params: { courses: courses_ids, session: { name: 'Web development' }}
      expect(response.code).to eq('201')

      created = Session.last
      expect(response.location).to eq("http://test.host/sessions/#{created.id}")

      expect(created.courses.size).to eq(2)
    end

    it 'returns 403 Forbidden when user has not sufficient roles' do
      student = User.create(email: 'student@example.com', password: '111', password_confirmation: '111')
      request.headers['Authorization'] = JWTUtils.encode({ user_id: student.id })

      post :create, params: { session: { name: 'Web development', courses: courses_ids }}
      expect(response.code).to eq('403')
    end
  end

  describe 'GET /sessions' do
    it 'retrieves all sessions' do
      PublisherService.create_session('web development', [])

      get :index
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)[0]['name']).to eq('web development')
    end

    it 'returns 403 Forbidden when user has not sufficient roles' do
      student = User.create(email: 'student@example.com', password: '111', password_confirmation: '111')
      request.headers['Authorization'] = JWTUtils.encode({ user_id: student.id })

      get :index
      expect(response.code).to eq('403')
    end
  end

  describe 'GET /sessions/:id' do
    it 'retrieves a session' do
      courses = Course.find(courses_ids)
      session = PublisherService.create_session('Web development', courses)

      get :show, { params: { id: session.id }}
      expect(response.code).to eq('200')

      data = JSON.parse(response.body)
      expect(data['name']).to eq('Web development')
      expect(data['courses'][0]['name']).to eq('Ruby programming')
      expect(data['courses'][1]['name']).to eq('Node programming')
    end

    it 'returns 404' do
      get :show, { params: { id: '111' }}
      expect(response.code).to eq('404')
    end

    it 'student has access' do
      student = User.create(email: 'student@example.com', password: '111', password_confirmation: '111')
      request.headers['Authorization'] = JWTUtils.encode({ user_id: student.id })

      session = PublisherService.create_session('Web development', [])

      get :show, { params: { id: session.id }}
      expect(response.code).to eq('200')
    end
  end
end
