# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result, aliases: [:martinborough_2014_result] do
    user
    race
    date Date.parse('2nd Nov 14')
    duration_s '3:52:10'
    fastest_duration_s '2:58:30'
    median_duration_s '3:56:47'
    wind '42'
    position 91
    finishers 194
    timing_url 'http://www.thetimingteam.co.nz/results/index.php?thread=1086439898&strand=1088774724&instance=72'
    strava_url 'https://www.strava.com/activities/214421767'
    comment 'Gale North-Westerlies'
  end

  factory :result_2015, class: Result, aliases: [:personal_best_result, :next_result] do
    date Date.parse('1st Nov 15')
    duration_s '3:27:22'
    fastest_duration_s '2:51:12'
    median_duration_s '3:27:27'
    wind '10'
    position 72
    finishers 155
    timing_url 'http://www.thetimingteam.co.nz/results/index.php?thread=158411318&strand=1850252633&instance=5526'
    strava_url 'https://www.strava.com/activities/424029948'
  end

  factory :result_2013, class: Result, aliases: [:previous_result] do
    date Date.parse('3rd Nov 13')
    duration_s '3:28:05'
    fastest_duration_s '2:55:54'
    median_duration_s '3:39:10'
    wind '19'
    position 86
    finishers 243
    timing_url 'http://www.thetimingteam.co.nz/results/index.php?thread=1170133413&strand=1316639235&instance=296'
    strava_url 'https://www.strava.com/activities/92832424'
  end

  factory :minimal_result, class: Result do
    date Date.parse('2nd Nov 14')
    duration_s '3:52:10'
  end

end
