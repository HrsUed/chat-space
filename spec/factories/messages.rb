FactoryGirl.define do
  factory :message do
    content   Faker::Lorem.sentence
    image     File.open("#{Rails.root}/public/images/ham2.jpg")
    group
    user
  end
end
