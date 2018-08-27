class PublishersController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher

  def test; head(:ok); end
end

describe PublishersController, type: :controller do
  before do
    Rails.application.routes.draw do
      get '/test' => 'publishers#test'
    end
  end

  after do
    Rails.application.reload_routes!
  end

  it 'performs the action' do
    publisher = User.create(email: 'user@example.com', password: '111', password_confirmation: '111')
    role = RoleService.create_role('publisher')
    RoleService.attach(role, publisher)

    token = JWTUtils.encode({ user_id: publisher.id })
    request.headers['Authorization'] = token

    get :test
    expect(response.code).to eq('200')
  end

  it 'returns 403 Forbidden when missing JWT' do
    request.headers['Authorization'] = nil

    get :test
    expect(response.code).to eq('403')
  end

  it 'returns 403 Forbidden for invalid JWT' do
    request.headers['Authorization'] = JWTUtils.encode({})

    get :test
    expect(response.code).to eq('403')
  end

  it 'returns 403 Forbidden when user has not sufficient roles' do
    student = User.create(email: 'student@example.com', password: '111', password_confirmation: '111')
    request.headers['Authorization'] = JWTUtils.encode({ user_id: student.id })

    get :test
    expect(response.code).to eq('403')
  end
end
