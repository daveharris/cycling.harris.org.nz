# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Smith"
    sequence(:email) { |n| "johnsmith#{n}@example.com" }
    password "secret"
  end
end
