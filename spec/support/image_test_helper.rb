module ImageTestHelper

  def uploaded_image
    'img[src*=".jpg"]'
  end

  def change_image_button
    '[data-confirm*="Are you sure?"][data-method="delete"]'
  end

  def upload_image(file_name)
    click_link 'My profile'
    attach_file 'image_picture', file_path(file_name)
    click_button 'Upload image'
  end

  def file_path(file_name)
    Rails.root.join('spec', 'support', 'files', file_name)
  end

end
