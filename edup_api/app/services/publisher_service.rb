class PublisherService

  def create_course(name)
    Course.new(name: name)
  end

  def publish_course(course)
    course.published = true
  end
end
