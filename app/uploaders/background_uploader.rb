class BackgroundUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process :fix_exif_rotation

  storage :file
  
  def store_dir
    "uploads/user/background/#{model.username}"
  end

  version :background do
    process resize_to_limit: [705, 170]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def fix_exif_rotation
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

end
