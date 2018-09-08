describe UploadService do
  let(:course)  { Course.create(name: 'Ruby programming') }
  let(:lesson)  { Lesson.create(course: course, name: 'Installation') }
  let(:content) { file_fixture('upload.txt').read }

  describe '#upload' do
    it 'attaches an upload to a lesson given upload params' do
      params = {
        src: "data:video/mp4;base64,#{Base64.encode64(content)}",
        title: 'upload.mp4'
      }

      described_class.upload(params, lesson)

      expect(lesson.upload.attached?).to eq(true)
      expect(lesson.upload.download).to eq("test1\ntest2\n")
    end

    it 'does not upload when params are blank' do
      described_class.upload({}, lesson)
      expect(lesson.upload.attached?).to eq(false)
    end
  end
end
