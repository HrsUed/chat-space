FactoryGirl.define do
  factory :message do
    content   Faker::Lorem.sentence
    image     File.open("#{Rails.root}/app/assets/images/noimage.png")
    group
    user
  end
end
