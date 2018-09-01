class LessonsController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher
  before_action :ensure_course_presence

  def destroy
    lesson = Lesson.find(params[:id])
    PublisherService.delete_lesson(lesson)

    render json: { id: params[:id] }
  end

  def index
    render json: Lesson.where(course_id: @course.id).order(created_at: :asc)
  end

  def create
    lesson = PublisherService.create_lesson(@course, lesson_params[:name])
    render json: lesson, status: 201, location: lesson_url(lesson)
  end

  def show
    lesson = Lesson.find(params[:id])
    render json: lesson
  end

  def update
    lesson = Lesson.find(params[:id])
    PublisherService.update_lesson(lesson, lesson_params)
    render json: lesson
  end

  private

  def ensure_course_presence
    @course ||= Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name)
  end
end
