class CoursesController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher, only: [:create, :update, :destroy]

  def create
    course = Course.create(name: course_params[:name])
    render json: course, status: 201, location: course_url(course)
  end

  def show
    course = Course.find(params[:id])
    render json: course.as_json(include: :lessons)
  end

  def index
    scope = authorize?('publisher') ? Course : Course.published
    render json: scope.order(created_at: :asc)
  end

  def destroy
    course = Course.find(params[:id])
    course.destroy

    render json: { id: params[:id] }
  end

  def update
    course = Course.find(params[:id])
    course.update_attributes(course_params)

    render json: course
  end

  private

  def course_params
    params.require(:course).permit(:name, :published)
  end
end
