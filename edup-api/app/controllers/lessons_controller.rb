class LessonsController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher

  def destroy
    lesson = Lesson.find(params[:id])
    PublisherService.delete_lesson(lesson)

    render json: { id: params[:id] }
  end

  def create
    course = Course.find(lesson_params[:course_id])
    lesson = PublisherService.create_lesson(course, lesson_params[:name])

    render json: lesson, status: 201, location: course_url(course)
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :course_id)
  end
end
