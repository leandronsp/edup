class EnrollmentService
  include Callable

  def enroll(user, course)
    course.users << user
  rescue ActiveRecord::RecordNotUnique
    true
  end
end
