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
      expect(course.published?).to eq(true)
    end
  end
end
