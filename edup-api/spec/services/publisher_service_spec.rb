describe PublisherService do
  describe '#create_course' do
    it 'creates a course given a name' do
      course = described_class.create_course('Ruby programming')
      expect(course.name).to eq('Ruby programming')
    end

    it 'the created course is not published' do
      course = described_class.create_course('Ruby programming')
      expect(course.published?).to eq(false)
    end
  end

  describe '#publish_course' do
    let(:course) { described_class.create_course('Ruby programming') }

    it 'publishes a course' do
      described_class.publish_course(course)
      expect(course.reload.published?).to eq(true)
    end
  end

  describe '#create_lesson' do
    let(:course) { described_class.create_course('Ruby programming') }

    it 'creates a lesson within the course' do
      lesson = described_class.create_lesson(course, 'Basics')

      expect(course.lessons[0].name).to eq('Basics')
      expect(lesson.course.name).to eq('Ruby programming')
    end

    it 'creates multiple lessons' do
      described_class.create_lesson(course, 'Basics')
      described_class.create_lesson(course, 'Advanced')

      expect(course.lessons.size).to eq(2)
    end
  end

  describe '#delete_course' do
    let(:course) { described_class.create_course('Ruby programming') }

    it 'destroys the course' do
      described_class.delete_course(course)
      expect { course.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#update_course' do
    let(:course) { described_class.create_course('Ruby programming') }

    it 'updates the course' do
      described_class.update_course(course, name: 'Java programming')
      expect(course.reload.name).to eq('Java programming')
    end

    it 'publishes a course' do
      described_class.update_course(course, published: true)
      expect(course.reload.published?).to eq(true)
    end
  end

  describe '#delete_lesson' do
    let(:course) { described_class.create_course('Ruby programming') }
    let(:lesson) { described_class.create_lesson(course, 'Ruby programming') }

    it 'destroys the lesson' do
      described_class.delete_lesson(lesson)
      expect { lesson.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(course.lessons.size).to eq(0)
    end
  end

  describe '#update_lesson' do
    let(:course) { described_class.create_course('Ruby programming') }
    let(:lesson) { described_class.create_lesson(course, 'Basics') }

    it 'updates the lesson ' do
      described_class.update_lesson(lesson, name: 'Installation')
      expect(lesson.reload.name).to eq('Installation')
    end
  end
end
