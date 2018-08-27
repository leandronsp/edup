class StudentsController < ApplicationController
  include Authorizable
  def test; head(:ok); end
end

describe StudentsController, type: :controller do
  before do
    Rails.application.routes.draw do
      get '/test' => 'students#test'
    end
  end

  after do
    Rails.application.reload_routes!
  end

  it 'performs the action' do
    user = User.create(email: 'user@example.com', password: '111', password_confirmation: '111')
    token = JWTUtils.encode({ user_id: user.id })
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
end
