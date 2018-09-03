describe EnrollmentService do
  let(:user) { build_user }

  describe '#enroll' do
    it 'enrolls a user to a course' do
      course = Course.create(name: 'Ruby')
      described_class.enroll(user, course)

      expect(course.users.size).to eq(1)
      expect(user.courses[0].id).to eq(course.id)
    end

    it 'does not duplicate enrollment' do
      course = Course.create(name: 'Ruby')
      described_class.enroll(user, course)
      described_class.enroll(user, course)

      expect(course.users.size).to eq(1)
      expect(user.courses.size).to eq(1)
      expect(user.courses[0].id).to eq(course.id)
    end
  end
end
