# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    user
    race
    duration 3600
    date '2014-10-15'
    comment 'My comments'
    timing_url 'http://timing.com'
    strava_url 'http://strava.com'
  end
end
