FactoryGirl.define do

  factory :post do
    title Faker::Lorem.sentence
    summary Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    user
  end

end
