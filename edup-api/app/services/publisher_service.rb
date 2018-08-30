class PublisherService
  include Callable

  def create_course(name)
    Course.create(name: name)
  end

  def publish_course(course)
    course.update_attribute(:published, true)
  end

  def create_lesson(course, name)
    Lesson.create(name: name, course: course)
  end

  def update_course(course, params)
    course.update_attribute(:name, params[:name])
  end

  def update_lesson_name(lesson, name)
    lesson.update_attribute(:name, name)
  end

  def create_session(name, courses)
    Session.create(name: name, courses: courses)
  end

  def update_session_name(session, name)
    session.update_attribute(:name, name)
  end

  def delete_course(course)
    course.destroy
  end
end
