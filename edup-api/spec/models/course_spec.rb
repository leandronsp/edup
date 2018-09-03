describe Course, type: :model do
  it 'creates a course' do
    expect(Course.create(name: 'Ruby').name).to eq('Ruby')
  end

  describe 'published' do
    it 'returns only published courses' do
      Course.create(name: 'Ruby')
      Course.create(name: 'Java', published: true)
      Course.create(name: 'Node', published: true)

      expect(Course.published.count).to eq(2)
    end
  end
end
