describe Lesson, type: :model do
  it 'creates a lesson' do
    expect(Lesson.create(name: 'Basics').name).to eq('Basics')
  end

  it 'attaches an upload' do
    content = file_fixture('upload.txt').read
    encoded = Base64.encode64(content)

    File.open("#{Rails.root}/tmp/videos/upload", 'wb') do |f|
      f.write(Base64.decode64(encoded))
    end

    lesson = Lesson.create(name: 'Basics')
    lesson.upload.attach(io: File.open("#{Rails.root}/tmp/videos/upload"), filename: "upload.txt")

    expect(lesson.upload.download).to eq("test1\ntest2\n")
  end
end
