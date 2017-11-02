require 'spec_helper'
require 'rails_helper'

describe 'Vote' do

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

  scenario 'should be added as "like"' do
    open_posts_details(@title)
    init_votes_number = posts_votes('like')
    vote_the_post('like')
    expect(posts_votes('like')).to eq(init_votes_number + 1)
  end

  scenario 'should be added as "dislike"' do
    open_posts_details(@title)
    init_votes_number = posts_votes('dislike')
    vote_the_post('dislike')
    expect(posts_votes('dislike')).to eq(init_votes_number + 1)
  end

  scenario 'should not be added if user isn\'t logged in' do
    logout
    expect(page).not_to have_css(votes_counter('dislike'))
    expect(page).not_to have_css(votes_counter('like'))
  end

  scenario 'as "like" should be took away' do
    open_posts_details(@title)
    init_votes_number = posts_votes('like')
    vote_the_post('like')
    vote_the_post('like')
    expect(posts_votes('like')).to eq(init_votes_number)
  end

  scenario 'as "dislike" should be took away' do
    open_posts_details(@title)
    init_votes_number = posts_votes('dislike')
    vote_the_post('dislike')
    vote_the_post('dislike')
    expect(posts_votes('dislike')).to eq(init_votes_number)
  end

  scenario 'as "like" should be changed on "dislike"' do
    open_posts_details(@title)
    vote_the_post('like')
    init_votes_number = posts_votes('dislike')
    vote_the_post('dislike')
    expect(posts_votes('like')).to eq 0
    expect(posts_votes('dislike')).to eq(init_votes_number + 1)
  end

  scenario 'as "dislike" should be changed on "like"' do
    open_posts_details(@title)
    vote_the_post('dislike')
    init_votes_number = posts_votes('like')
    vote_the_post('like')
    expect(posts_votes('dislike')).to eq 0
    expect(posts_votes('like')).to eq(init_votes_number + 1)
  end

end
