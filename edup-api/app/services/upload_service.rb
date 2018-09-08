class UploadService
  include Callable

  def upload(upload_params, lesson)
    return if upload_params.blank?

    src, title = upload_params.values_at(:src, :title)
    temp_filename  = "#{Rails.root}/tmp/videos/upload"

    File.open(temp_filename, 'wb') do |f|
      encoded = src.split(/data:video\/mp4;base64,/)[1]
      f.write(Base64.decode64(encoded))
    end

    lesson.upload.attach(io: File.open(temp_filename), filename: title)
    lesson.save!
  end
end
