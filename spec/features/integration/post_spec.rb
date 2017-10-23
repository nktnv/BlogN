require 'spec_helper'
require 'rails_helper'

describe 'Post' do

  before(:all) do
    @email = Faker::Internet.email
    @email2 = Faker::Internet.email
    @password = Faker::Internet.password
    @password2 = Faker::Internet.password
    @user = create(:user, email: @email, password_digest: encrypted_password(@password))
    @user = create(:user, email: @email2, password_digest: encrypted_password(@password2))
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

  scenario 'create link should be displayed on "My posts" page' do
    logout
    login(@email2, @password2)
    click_link 'My posts'
    expect(page).to have_xpath(create_first_one_link)
  end

  scenario 'of another user should not be displayed on "My posts" page' do
    create_post(sentence, sentence, paragraph)
    logout
    login(@email2, @password2)
    expect(page).to have_content(sentence)
    click_link 'My posts'
    expect(page).not_to have_content(sentence)
  end

  scenario 'should be displayed on "My posts" page' do
    click_link 'My posts'
    create_post(sentence, sentence, paragraph)
    click_link 'My posts'
    expect(page).to have_content(sentence)
  end

end
