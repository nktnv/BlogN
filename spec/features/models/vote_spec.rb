require 'spec_helper'
require 'rails_helper'

describe Vote do

  let(:post_vote) { create(:post_vote) }
  let(:posts_comments_vote) { create(:posts_comments_vote) }

  it 'of post should have "Post" voteable_type' do
    expect(post_vote).to have_attributes(voteable_type: 'Post', attitude: 'like')
  end

  it 'of posts comment should have "Comment" voteable_type' do
    expect(posts_comments_vote).to have_attributes(voteable_type: 'Comment', attitude: 'like')
  end

  it 'of comment should have "Comment" voteable_type' do
    expect(create(:comments_vote, attitude: :dislike)).to have_attributes(voteable_type: 'Comment', attitude: 'dislike')
  end

end
