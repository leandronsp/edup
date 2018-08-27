class LessonsController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher

  def create
    course = Course.find(lesson_params[:course_id])
    lesson = PublisherService.create_lesson(course, lesson_params[:name])

    render json: {}, status: 201, location: course_url(course)
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :course_id)
  end
end
