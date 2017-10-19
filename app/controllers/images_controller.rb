class ImagesController < ApplicationController

  include ImagesHelper
  include ApplicationHelper

  before_action :create_public_image_directory

  def create
    if params[:image][:picture]
      file = params[:image][:picture]
      file_extension = File.extname(file.original_filename)
      file.original_filename = random_value + file_extension
      File.open(absolute_public_image_path(file.original_filename), 'wb') do |f|
        f.write(file.read)
      end
      @image = Image.new(image_params.merge(picture: file.original_filename))
      @image.save ? redirect_to(user_path(current_user.id)) : redirect_to(:root)
    else
      redirect_to(user_path(current_user.id))
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    File.delete(absolute_public_image_path(@image.picture)) if
    redirect_to(user_path(current_user.id))
  end

  private

  def image_params
    params.require(:image).permit(:user_id, :picture)
  end

end
