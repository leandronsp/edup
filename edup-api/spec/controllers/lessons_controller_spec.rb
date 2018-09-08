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
      expect(JSON.parse(response.body)['upload_url']).to eq(nil)
    end

    it 'includes upload url' do
      create_upload_for(lesson, name: 'lesson_2.mp4')

      get :show, { params: { course_id: course.id, id: lesson.id }}
      expect(response.code).to eq('200')

      result = JSON.parse(response.body)
      expect(result['name']).to eq('Basics')
      expect(result['course_id']).to eq(course.id)
      expect(result['upload_url']).to match(/http:\/\/test\.host.*?lesson_2\.mp4/)
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
      put :update, { params: { id: lesson.id, course_id: course.id,
        lesson: { name: 'Installation', source_url: 'https://www.youtube.com/watch?v=abcd' }}}
      expect(response.code).to eq('200')
      expect(lesson.reload.name).to eq('Installation')
      expect(lesson.reload.source_url).to eq('https://www.youtube.com/watch?v=abcd')
    end

    it 'attaches an upload' do
      content = file_fixture('upload.txt').read
      base64_content = "data:video/mp4;base64,#{Base64.encode64(content)}"

      put :update, { params: { id: lesson.id, course_id: course.id,
        upload: { src: base64_content, title: 'lesson1.mp4' },
        lesson: {
          name: 'Installation',
          source_url: 'https://www.youtube.com/watch?v=abcd'
        }}}

      expect(response.code).to eq('200')
      expect(lesson.reload.name).to eq('Installation')
      expect(lesson.reload.source_url).to eq('https://www.youtube.com/watch?v=abcd')
      expect(lesson.reload.upload.download).to eq("test1\ntest2\n")
    end
  end
end
