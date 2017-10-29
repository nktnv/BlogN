module ImagesHelper

  def create_public_image_directory
    directory_name = File.join(File.dirname(__FILE__), '../../public/images')
    Dir.mkdir(directory_name) unless File.directory?(directory_name)
  end

  def absolute_public_image_path(file_name)
    Rails.root.join('public', 'images', file_name)
  end

  def create_image(file_name, uploaded_file)
    File.open(file_name, 'wb') do |f|
      f.write(uploaded_file)
    end
    file_name
  end

  def upload_file_to_cloudinary(file, public_id)
    response = Cloudinary::Uploader.upload(file, folder: Rails.env, public_id: public_id)
    response['url']
  end

  def delete_file_on_cloudinary(url)
    public_id = url.split('/').last.split('.').first
    Cloudinary::Uploader.destroy("#{Rails.env}/#{public_id}")
  end

  def clean_public_image_directory
    FileUtils.rm_rf(Dir.glob('public/images/*'))
  end

  def no_avatar_image
    '/no_avatar.png'
  end

  def image_content_type?(uploaded_obj)
    uploaded_obj.content_type.include?('image')
  end

end
