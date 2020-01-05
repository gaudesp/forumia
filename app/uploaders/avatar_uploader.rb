class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['user_avatar']

  version :avatar do
    process :resize_to_fill => [300, 300, :north]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def public_id
    "uploads/user/avatar/#{model.username}"
  end

end
