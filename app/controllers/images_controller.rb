class ImagesController < ApplicationController

  def create
    @image = Image.create(image_params)
    if params[:image].present?
      file =  params[:image][:picture]
      create_image_directory
      File.open(Rails.root.join('public', 'images', file.original_filename), 'wb') do |f|
        f.write(file.read)
      end
      @image.picture = '/public/images/' + file.original_filename
    end
    redirect_to user_path(current_user.id)
  end

  private

  def image_params
    params.require(:image).permit(:name, :picture, :user_id)
  end

  def create_image_directory
    directory_name = File.join(File.dirname(__FILE__), '../../public/images')
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
  end

end
