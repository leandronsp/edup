describe LessonsController, type: :controller do
  let(:publisher) { User.create(email: 'publisher@example.com', password: '111', password_confirmation: '111') }

  before do
    role = RoleService.create_role('publisher')
    RoleService.attach(role, publisher)

    token = JWTUtils.encode({ user_id: publisher.id })
    request.headers['Authorization'] = token
  end

  describe 'POST /courses/:course_id/lessons' do
    it 'creates a new lesson under a course and returns the course location' do
      course = PublisherService.create_course('Ruby programming')
      post :create,
        params: { course_id: course.id, lesson: { name: 'Basics', course_id: course.id }}

      expect(response.code).to eq('201')

      expect(response.location).to eq("http://test.host/courses/#{course.id}")
      expect(course.lessons[0].name).to eq('Basics')
    end
  end
end
