FactoryGirl.define do

  factory :post_comment, class: 'Comment' do
    body Faker::Lorem.sentence
    association :commentable, factory: :post
    user
  end

  factory :post_comments_comment, class: 'Comment' do
    body Faker::Lorem.sentence
    association :commentable, factory: :post_comment
    user
  end

  factory :comments_comment, class: 'Comment' do
    body Faker::Lorem.sentence
    association :commentable, factory: :post_comments_comment
    user
  end

end
