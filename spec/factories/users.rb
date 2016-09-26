# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [:dave] do
    first_name 'Dave'
    last_name 'Harris'
    email 'dave@harris.org.nz'
    password 'password'

    factory :ian do
      first_name 'Ian'
      last_name 'Harris'
      email 'ian@harris.org.nz'
    end
  end
end
