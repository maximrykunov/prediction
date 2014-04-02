FactoryGirl.define do
  factory :post do
    name        { Faker::Lorem.words(5).join(' ') }
    association :user
  end
end
