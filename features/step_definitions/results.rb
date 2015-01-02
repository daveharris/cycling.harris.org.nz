When(/^I filter results by user "(.*?)" and race "(.*?)"$/) do |user, race|
  visit "/results"
  select user, from: "result_user_id" if user.present?
  select race, from: "result_race_id" if race.present?
  click_button("Apply Filter") 
end