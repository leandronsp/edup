describe Lesson, type: :model do
  it 'creates a lesson' do
    expect(Lesson.create(name: 'Basics').name).to eq('Basics')
  end
end
