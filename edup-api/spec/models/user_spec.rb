describe User, type: :model do
  it 'uses UUID as ID' do
    user = User.create(email: 'email@example.com', password: '111', password_confirmation: '111')
    expect(user.id).to match(/^[\w]{8}-[\w]{4}-[\w]{4}-[\w]{4}-[\w]{12}$/)
  end
end
