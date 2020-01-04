class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process :fix_exif_rotation

  storage :file
  
  def store_dir
    "uploads/user/avatar/#{model.username}"
  end

  version :avatar do
    process resize_to_limit: [300, 300]
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
