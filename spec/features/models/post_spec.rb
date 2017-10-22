require 'spec_helper'
require 'rails_helper'

describe Post do

  let(:post_without_summary) { create(:post, summary: nil) }

  it 'should be created with valid parameters' do
    expect(create(:post)).not_to be_nil
  end

  it 'should be created without a summary' do
    expect(post_without_summary).not_to be_nil
  end

  it 'summary field should be nil if it was not passed' do
    posts_summary = Post.find(post_without_summary.id).summary
    expect(posts_summary).to be_nil
  end

end
