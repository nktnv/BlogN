require 'spec_helper'
require 'rails_helper'

describe Comment do

  let(:posts_comment) { create(:post_comment) }
  let(:post_comments_comment) { create(:post_comments_comment) }
  let(:comments_comment) { create(:comments_comment) }

  it 'of post should have "Post" commentable_type' do
    expect(posts_comment).to have_attributes(commentable_type: 'Post')
  end

  it 'of posts comment should have "Comment" commentable_type' do
    expect(post_comments_comment).to have_attributes(commentable_type: 'Comment')
  end

  it 'of comment should have "Comment" commentable_type' do
    expect(comments_comment).to have_attributes(commentable_type: 'Comment')
  end

end
