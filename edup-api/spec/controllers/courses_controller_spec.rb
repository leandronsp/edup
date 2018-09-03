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
    it 'retrieves all the courses ordered by creation date' do
      Course.create(name: 'Ruby programming')
      Course.create(name: 'Java programming')
      Course.create(name: 'Node programming')

      Course.find_by(name: 'Java programming').update_attribute(:published, true)

      get :index
      expect(response.code).to eq('200')

      result = JSON.parse(response.body)
      expect(result[0]['name']).to eq('Ruby programming')
      expect(result[1]['name']).to eq('Java programming')
      expect(result[2]['name']).to eq('Node programming')
    end
  end

  describe 'GET /courses/:id' do
    let(:course) { Course.create(name: 'Ruby programming') }

    it 'retrieves a course' do
      get :show, { params: { id: course.id }}
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['name']).to eq('Ruby programming')
    end

    it 'also includes lessons within course' do
      Lesson.create(course: course, name: 'Installation')

      get :show, { params: { id: course.id }}
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['lessons'].size).to eq(1)
    end

    it 'returns 404' do
      get :show, { params: { id: '111' }}
      expect(response.code).to eq('404')
    end
  end

  describe 'DELETE /courses/:id' do
    let(:course) { Course.create(name: 'Ruby programming') }

    it 'deletes a course' do
      _id = course.id

      delete :destroy, { params: { id: _id }}
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['id']).to eq(_id)
    end
  end

  describe 'UPDATE /courses/:id' do
    let(:course) { Course.create(name: 'Ruby programming') }

    it 'updates a course' do
      put :update, { params: { id: course.id, course: { name: 'Java programming' }}}
      expect(response.code).to eq('200')
      expect(course.reload.name).to eq('Java programming')
    end
  end
end
