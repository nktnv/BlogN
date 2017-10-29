class ImagesController < ApplicationController

  include ImagesHelper
  include ApplicationHelper

  before_action :create_public_image_directory
  after_action :clean_public_image_directory

  def create
    if params[:image][:picture] && image_content_type?(params[:image][:picture])
      file = params[:image][:picture]
      file_extension = File.extname(file.original_filename)
      file.original_filename = random_value + file_extension
      file_path = create_image(absolute_public_image_path(file.original_filename), file.read)
      file_url = upload_file_to_cloudinary(file_path, random_value(20))
      @image = Image.new(image_params.merge(picture: file_url))
      if @image.save
        redirect_to(user_path(current_user.id))
        flash[:success] = 'Image was uploaded successfully.'
      else
        redirect_to(:root)
        flash[:error] = 'Something went wrong.'
      end
    else
      redirect_to(user_path(current_user.id))
      flash[:error] = 'Please, choose an image.'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    delete_file_on_cloudinary(@image.picture)
    @image.destroy
    redirect_to(user_path(current_user.id))
  end

  private

  def image_params
    params.require(:image).permit(:user_id, :picture)
  end

end
