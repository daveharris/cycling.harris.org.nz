# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    user
    race
    duration_s "1:30:00"
    fastest_duration_s "1:00:00"
    median_duration_s "2:00:00"
    date '2014-10-15'
    comment 'My comments'
    timing_url 'http://timing.com'
    strava_url 'http://strava.com'
  end
end
