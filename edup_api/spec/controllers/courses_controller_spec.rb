describe CoursesController, type: :controller do
  describe 'POST /courses' do
    it 'creates a new course' do
      post :create, params: { course: { name: 'Ruby programming' }}
      expect(response.code).to eq('201')

      created = Course.last
      expect(response.location).to eq("http://test.host/courses/#{created.id}")
    end
  end
end
