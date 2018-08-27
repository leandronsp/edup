class CoursesController < ApplicationController
  def create
    course = publisher_service.create_course(course_params[:name])
    render json: {}, status: 201, location: course_url(course)
  end

  private

  def publisher_service
    PublisherService.new
  end

  def course_params
    params.require(:course).permit(:name)
  end
end
