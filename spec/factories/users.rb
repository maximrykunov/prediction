FactoryGirl.define do
  factory :user do
    name { "#{ Faker::Name.first_name } #{ Faker::Name.last_name }" }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password '11111111'
    password_confirmation '11111111'
    confirmed_at Date.yesterday
  end
end
