describe LessonsController, type: :controller do
  let(:course) { Course.create(name: 'Ruby programming') }

  before do
    authenticate_as_publisher
  end

  describe 'POST /lessons' do
    it 'creates a new lesson under a course and returns the location' do
      post :create,
        params: { course_id: course.id, lesson: { name: 'Basics' }}

      expect(response.code).to eq('201')

      created = Lesson.last
      expect(response.location).to eq("http://test.host/lessons/#{created.id}")
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
    let(:course) { Course.create(name: 'Ruby programming') }
    let(:lesson) { Lesson.create(course: course, name: 'Basics') }

    it 'deletes a lesson' do
      _id = lesson.id

      delete :destroy, { params: { course_id: course.id, id: _id }}
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['id']).to eq(_id)
    end
  end

  describe 'GET /lessons' do
    let(:course) { Course.create(name: 'Ruby programming') }
    let(:lesson) { Lesson.create(course: course, name: 'Basics') }

    it 'retrieves all the lessons within a course' do
      get :index, { params: { course_id: lesson.course_id }}
      expect(response.code).to eq('200')

      result = JSON.parse(response.body)
      expect(result[0]['name']).to eq('Basics')
    end
  end

  describe 'GET /lessons/:id' do
    let(:course) { Course.create(name: 'Ruby programming') }
    let(:lesson) { Lesson.create(course: course, name: 'Basics') }

    it 'retrieves a lesson' do
      get :show, { params: { course_id: course.id, id: lesson.id }}
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['name']).to eq('Basics')
      expect(JSON.parse(response.body)['course_id']).to eq(course.id)
    end

    it 'returns 404 when lesson not found' do
      get :show, { params: { course_id: course.id, id: '111' }}
      expect(response.code).to eq('404')
    end
  end

  describe 'UPDATE /lessons/:id' do
    let(:course) { Course.create(name: 'Ruby programming') }
    let(:lesson) { Lesson.create(course: course, name: 'Basics') }

    it 'updates a lesson' do
      put :update, { params: { id: lesson.id, course_id: course.id, lesson: { name: 'Installation' }}}
      expect(response.code).to eq('200')
      expect(lesson.reload.name).to eq('Installation')
    end
  end
end
