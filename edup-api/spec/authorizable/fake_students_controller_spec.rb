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
    authenticate_as_student

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
end
