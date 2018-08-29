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
    authenticate_as_publisher

    get :test
    expect(response.code).to eq('200')
  end

  it 'returns 403 Forbidden when missing JWT' do
    request.headers['Authorization'] = nil

    get :test
    expect(response.code).to eq('403')
  end

  it 'returns 403 Forbidden for invalid JWT' do
    request.headers['Authorization'] = invalid_token

    get :test
    expect(response.code).to eq('403')
  end

  it 'returns 403 Forbidden when user has not sufficient roles' do
    authenticate_as_student

    get :test
    expect(response.code).to eq('403')
  end
end
