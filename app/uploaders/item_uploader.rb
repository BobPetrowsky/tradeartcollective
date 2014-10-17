class ItemUploader < CarrierWave::Uploader::Base

  storage :fog

  def pre_limit file
    if file && file.size > 0.1.megabytes
      raise Exception.new("too large")
    end
    true
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png mp4)
  end

end
