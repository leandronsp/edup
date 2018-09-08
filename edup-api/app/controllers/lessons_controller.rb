class LessonsController < ApplicationController
  include Authorizable
  before_action :ensure_user_is_publisher, except: [:show]

  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy

    render json: { id: params[:id] }
  end

  def index
    ensure_course_presence
    render json: Lesson.where(course_id: @course.id).order(created_at: :asc)
  end

  def create
    ensure_course_presence
    lesson = Lesson.create(course: @course, name: lesson_params[:name])

    render json: lesson, status: 201, location: lesson_url(lesson)
  end

  def show
    lesson = Lesson.find(params[:id])
    if lesson.upload.present? && lesson.upload.attached?
      upload_url = rails_blob_url(lesson.upload)
      upload_filename = lesson.upload.filename
    end

    render json: lesson.as_json.merge(
      upload_url: upload_url,
      upload_filename: upload_filename
    )
  end

  def update
    lesson = Lesson.find(params[:id])
    lesson.update_attributes(lesson_params)

    UploadService.upload(params[:upload], lesson)

    render json: lesson
  end

  private

  def ensure_course_presence
    @course ||= Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :source_url)
  end
end
