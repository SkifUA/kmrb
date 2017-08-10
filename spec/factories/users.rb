FactoryGirl.define do
  factory :user do
    id 1
    first_name "Example"
    last_name 'User'
    email "user@example.com"
    password '1111'
    password_confirmation '1111'
    activated true
  end
end
