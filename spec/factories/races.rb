# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :race do
    name 'Test Cycle Race'
    distance 1
    url 'http://example.com'
  end
end
