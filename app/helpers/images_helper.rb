module ImagesHelper

  def create_public_image_directory
    directory_name = File.join(File.dirname(__FILE__), '../../public/images')
    Dir.mkdir(directory_name) unless File.directory?(directory_name)
  end

  def absolute_public_image_path(file_name)
    Rails.root.join('public', 'images', file_name)
  end

  def public_images_path(image)
    image.nil? ? '/images/no_avatar.png' : "/images/#{image.picture}"
  end

end
