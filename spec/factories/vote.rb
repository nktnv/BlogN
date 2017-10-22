FactoryGirl.define do

  factory :post_vote, class: 'Vote' do
    attitude :like
    association :voteable, factory: :post
    user
  end

  factory :posts_comments_vote, class: 'Vote' do
    attitude :like
    association :voteable, factory: :post_comment
    user
  end

  factory :comments_vote, class: 'Vote' do
    attitude :like
    association :voteable, factory: :comments_comment
    user
  end

end
