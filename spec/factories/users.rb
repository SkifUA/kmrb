FactoryGirl.define do
  factory :user do
    first_name "Example"
    last_name 'User'
    email "user@example.com"
    password '111111'
    password_confirmation '111111'
  end
end
