describe Session, type: :model do
  it 'creates a session' do
    expect(Session.create(name: 'web dev').name).to eq('web dev')
  end
end
