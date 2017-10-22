require 'spec_helper'
require 'rails_helper'

describe 'Comment' do

  before(:all) do
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    @title = Faker::Lorem.sentence
    create(:user, email: @email, password_digest: encrypted_password(@password))
    create(:post, title: @title, summary: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
  end

  before(:each) do
    login(@email, @password)
  end

  let(:message) { Faker::Lorem.sentence }

  scenario 'can be added to post' do
    add_posts_comment(@title, message)
    expect(page).to have_xpath(comment_xpath(message))
  end

  scenario 'can be added to another comment' do
    parent_message = Faker::Lorem.sentence
    new_message = Faker::Lorem.sentence
    add_posts_comment(@title, parent_message)
    interact_wih_comment('Reply', parent_message, new_message)
    expect(page).to have_content(new_message)
    expect(page).to have_content(parent_message)
  end

  scenario 'can be edited' do
    new_message = Faker::Lorem.sentence
    add_posts_comment(@title, message)
    interact_wih_comment('Edit', message, new_message)
    expect(page).to have_content(new_message)
    expect(page).not_to have_content(message)
  end

  scenario 'can be deleted' do
    add_posts_comment(@title, message)
    interact_wih_comment('Delete', message)
    expect(page).not_to have_content(message)
  end

  scenario 'cannot be added if user isn\'t logged in' do
    logout
    open_posts_details(@title)
    expect(page).not_to have_css(send_comment_button)
  end

end
