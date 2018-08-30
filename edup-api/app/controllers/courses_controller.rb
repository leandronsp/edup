class CoursesController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher

  def create
    course = PublisherService.create_course(course_params[:name])
    render json: course, status: 201, location: course_url(course)
  end

  def show
    course = Course.find(params[:id])
    render json: course
  end

  def index
    render json: Course.all
  end

  def destroy
    course = Course.find(params[:id])
    PublisherService.delete_course(course)
    render json: { id: params[:id] }
  end

  def update
    course = Course.find(params[:id])
    PublisherService.update_course(course, course_params)
    render json: course
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
