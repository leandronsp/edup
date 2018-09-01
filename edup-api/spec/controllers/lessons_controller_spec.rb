describe LessonsController, type: :controller do
  let(:course) { PublisherService.create_course('Ruby programming') }

  before do
    authenticate_as_publisher
  end

  describe 'POST /lessons' do
    it 'creates a new lesson under a course and returns the course location' do
      post :create,
        params: { lesson: { name: 'Basics', course_id: course.id }}

      expect(response.code).to eq('201')

      expect(response.location).to eq("http://test.host/courses/#{course.id}")
      expect(JSON.parse(response.body)['name']).to eq('Basics')
      expect(course.lessons[0].name).to eq('Basics')
      expect(course.lessons[0].course_id).to eq(course.id)
    end

    it 'returns 404 when course is not found' do
      post :create,
        params: { lesson: { name: 'Basics', course_id: 'not found' }}

      expect(response.code).to eq('404')
    end
  end

  describe 'DELETE /lessons/:id' do
    let(:course) { PublisherService.create_course('Ruby programming') }
    let(:lesson) { PublisherService.create_lesson(course, 'Basics') }

    it 'deletes a lesson' do
      _id = lesson.id

      delete :destroy, { params: { id: _id }}
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['id']).to eq(_id)
    end
  end
end
