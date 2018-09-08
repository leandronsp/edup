class CoursesController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher, only: [:create, :update, :destroy]

  def create
    course = Course.create(name: course_params[:name])
    render json: course, status: 201, location: course_url(course)
  end

  def show
    course = Course.find(params[:id])
    EnrollmentService.enroll(current_user, course) if authorize?('student')

    lessons_as_json = course.lessons.map do |lesson|
      if lesson.upload.present? && lesson.upload.attached?
        upload_url = rails_blob_url(lesson.upload)
        upload_filename = lesson.upload.filename
      end

      lesson.as_json.merge(
        upload_url: upload_url,
        upload_filename: upload_filename
      )
    end

    render json: course.as_json(include: [:students]).merge(lessons: lessons_as_json)
  end

  def index
    scope = authorize?('publisher') ? Course : Course.published

    render json: (scope.order(created_at: :asc).map do |course|
      course.as_json(include: :students)
    end)
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
