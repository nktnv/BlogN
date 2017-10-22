require 'spec_helper'
require 'rails_helper'

describe 'Image' do

  before(:all) do
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    create(:user, email: @email, password_digest: encrypted_password(@password))
  end

  before(:each) do
    login(@email, @password)
  end

  scenario 'should not be uploaded initially' do
    expect(page).not_to have_css(uploaded_image)
  end

  scenario 'should be uploaded in users profile' do
    upload_image('squirrel.jpg')
    expect(page).to have_css(uploaded_image)
  end

  scenario 'should be deleted for users profile' do
    upload_image('squirrel.jpg')
    expect(page).to have_css(change_image_button)
  end

end
