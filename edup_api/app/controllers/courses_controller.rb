class CoursesController < ApplicationController
  def create
    course = PublisherService.create_course(course_params[:name])
    render json: {}, status: 201, location: course_url(course)
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
