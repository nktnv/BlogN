require 'spec_helper'
require 'rails_helper'

describe 'Post' do

  before(:all) do
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    @user = create(:user, email: @email, password_digest: encrypted_password(@password))
  end

  before(:each) do
    login(@email, @password)
  end

  let(:sentence) { Faker::Lorem.sentence }
  let(:paragraph) { Faker::Lorem.paragraph }

  scenario 'should be created' do
    create_post(sentence, sentence, paragraph)
    expect(page).to have_content(sentence)
  end

  scenario 'should be edited' do
    title = Faker::Lorem.sentence
    new_title = Faker::Lorem.sentence
    create_post(title, sentence, paragraph)
    edit_post(title, new_title)
    expect(page).to have_content(new_title)
    expect(page).not_to have_content(title)
  end

  scenario 'should be deleted' do
    create_post(sentence, sentence, paragraph)
    open_posts_details(sentence)
    expect(page).to have_css(delete_post_link)
  end

  scenario 'cannot be created if user was logout' do
    logout
    expect(page).not_to have_content('Create new post')
  end

  scenario 'cannot be edited if user was logout' do
    create_post(sentence, sentence, paragraph)
    logout
    open_posts_details(sentence)
    expect(page).not_to have_content('Edit')
  end

  scenario 'cannot be deleted if user was logout' do
    create_post(sentence, sentence, paragraph)
    logout
    open_posts_details(sentence)
    expect(page).not_to have_css(delete_post_link)
  end

end
