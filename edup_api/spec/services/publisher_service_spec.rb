describe PublisherService do
  describe '#create_course' do
    it 'creates a course given a name' do
      course = subject.create_course('Ruby programming')
      expect(course.name).to eq('Ruby programming')
    end

    it 'the created course is not published' do
      course = subject.create_course('Ruby programming')
      expect(course.published?).to eq(false)
    end
  end

  describe '#publish_course' do
    let(:course) { subject.create_course('Ruby programming') }

    it 'publishes a course' do
      subject.publish_course(course)
      expect(course.reload.published?).to eq(true)
    end
  end

  describe '#create_lesson' do
    let(:course) { subject.create_course('Ruby programming') }

    it 'creates a lesson within the course' do
      lesson = subject.create_lesson(course, 'Basics')

      expect(course.lessons[0].name).to eq('Basics')
      expect(lesson.course.name).to eq('Ruby programming')
    end

    it 'creates multiple lessons' do
      subject.create_lesson(course, 'Basics')
      subject.create_lesson(course, 'Advanced')

      expect(course.lessons.size).to eq(2)
    end
  end

  describe '#update_course_name' do
    let(:course) { subject.create_course('Ruby programming') }

    it 'updates the course name' do
      subject.update_course_name(course, 'NodeJS crash course')
      expect(course.reload.name).to eq('NodeJS crash course')
    end
  end

  describe '#update_lesson_name' do
    let(:course) { subject.create_course('Ruby programming') }
    let(:lesson) { subject.create_lesson(course, 'Basics') }

    it 'updates the lesson name' do
      subject.update_lesson_name(lesson, 'Advanced')
      expect(lesson.reload.name).to eq('Advanced')
    end
  end

  describe '#create_session' do
    it 'creates a session of courses' do
      course_a = subject.create_course('NodeJS programming')
      course_b = subject.create_course('Ruby programming')

      session = subject.create_session('Web development', [course_a, course_b])

      expect(session.name).to eq('Web development')
      expect(session.reload.courses.size).to eq(2)
      expect(course_a.sessions.size).to eq(1)
    end
  end

  describe '#update_session_name' do
    let(:course) { subject.create_course('Ruby programming') }
    let(:session) { subject.create_session('Web dev', [course]) }

    it 'updates the session name' do
      subject.update_session_name(session, 'Web development')
      expect(session.reload.name).to eq('Web development')
    end
  end
end
