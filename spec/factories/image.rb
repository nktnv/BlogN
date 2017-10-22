FactoryGirl.define do

  factory :image do
    picture Faker::File.file_name
    user
  end

end
