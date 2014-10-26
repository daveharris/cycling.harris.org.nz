# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    user nil
    race nil
    date "2014-10-15"
    comment "MyText"
    url "MyText"
  end
end
