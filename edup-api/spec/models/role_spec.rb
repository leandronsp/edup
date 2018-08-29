describe Role, type: :model do
  it 'creates a role' do
    expect(Role.create(name: 'student').name).to eq('student')
  end
end
