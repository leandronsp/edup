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
  end
end
