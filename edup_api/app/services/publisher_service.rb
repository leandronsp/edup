class PublisherService

  def create_course(name)
    Course.create(name: name)
  end

  def publish_course(course)
    course.update_attribute(:published, true)
  end

  def create_lesson(course, name)
    Lesson.create(name: name, course: course)
  end
end
