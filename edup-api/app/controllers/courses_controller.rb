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

    render json: serialize_with_students_and_lessons(course)
  end

  def index
    scope = authorize?('publisher') ? Course : Course.published
    courses = scope.order(created_at: :asc)

    render json: courses.map(&method(:serialize_with_students))
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

  def serialize_with_students(course)
    course.as_json(include: [:students])
  end

  def serialize_with_students_and_lessons(course)
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

    serialize_with_students(course).merge(lessons: lessons_as_json)
  end

  def course_params
    params.require(:course).permit(:name, :published)
  end
end
