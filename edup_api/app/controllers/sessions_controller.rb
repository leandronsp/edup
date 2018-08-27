class SessionsController < ApplicationController
  include Authorizable

  def create
    ensure_user_is_publisher

    courses = Course.find(params[:courses])
    session = PublisherService.create_session(session_params[:name], courses)
    render json: {}, status: 201, location: session_url(session)
  end

  def index
    ensure_user_is_publisher
    render json: Session.all
  end

  def show
    session = Session.find(params[:id])
    render json: { id: session.id, name: session.name, courses: session.courses }
  end

  private

  def session_params
    params.permit(:name)
  end
end
