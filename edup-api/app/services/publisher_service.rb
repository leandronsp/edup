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
    course.update_attributes(params)
  end

  def update_lesson(lesson, params)
    lesson.update_attributes(params)
  end

  def delete_course(course)
    course.destroy
  end

  def delete_lesson(lesson)
    lesson.destroy
  end
end
