require 'spec_helper'
require 'rails_helper'

describe 'User' do

  before(:all) do
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    @user = create(:user, email: @email, password_digest: BCrypt::Password.create(@password))
  end

  scenario 'can sign up' do
    first_name = Faker::Name.first_name
    sign_up(first_name, Faker::Name.last_name, Faker::Internet.email, Faker::Internet.password)
    expect(page).to have_content "Hi, #{first_name}!"
  end

  scenario 'can log in' do
    login(@email, @password)
    expect(page).to have_content "Hi, #{@user.first_name}!"
  end

  scenario 'can log out' do
    login(@email, @password)
    logout
    expect(page).not_to have_content "Hi, #{@user.first_name}!"
  end

  scenario 'cannot log in if it is not registered' do
    login(Faker::Internet.email, Faker::Internet.password)
    expect(page).not_to have_content "Hi, #{@user.first_name}!"
  end

  scenario 'can open profile' do
    login(@email, @password)
    click_link('My profile')
    expect(page).to have_content " First name: #{@user.first_name}"
  end

end
