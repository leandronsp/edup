describe Course, type: :model do
  it 'creates a course' do
    expect(Course.create(name: 'Ruby').name).to eq('Ruby')
  end
end
