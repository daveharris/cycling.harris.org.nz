# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :race, aliases: [:martinborough_race] do
    name 'Martinborough Charity Fun Ride'
    distance 115
  end

  factory :taupo_race, class: Race do
    name 'Taupo Cycle Challenge'
    distance 160
  end
end
