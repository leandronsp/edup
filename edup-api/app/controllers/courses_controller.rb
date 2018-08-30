class CoursesController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher

  def create
    course = PublisherService.create_course(course_params[:name])
    render json: {}, status: 201, location: course_url(course)
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
    head :ok
  end

  def update
    course = Course.find(params[:id])
    PublisherService.update_course(course, course_params)
    head :ok
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
