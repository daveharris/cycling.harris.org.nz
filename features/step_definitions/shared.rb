# Page Steps

Given(/^I visit "(.+)"$/) do |path|
  visit path
end

Then(/^I should see "(.+)"$/) do |text|
  expect(page).to have_content text
end

# Then(/^I should not see "(.*?)"$/) do |arg1|
#   expect(page).to have_no_content text
# end

Then(/^I should see "(.+)" at "(.+)"$/) do |text, css|
  expect(page).to have_css(css, text: text)
end

Then(/^I should see a link to "(.+)"$/) do |text|
  expect(page).to have_link(text)
end

Then(/^I should not see a link to "(.+)"$/) do |text|
  expect(page).to_not have_link(text)
end

Then /^"(.+)" should be selected for "(.+)"$/ do |value, field|
  expect(page).to have_xpath("//option[@selected = 'selected' and contains(string(), '#{value}')]")
end

Then(/^show me the page$/) do
  save_and_open_page
end

# Authentication Steps

Given /^I am logged in$/ do
  @current_user = FactoryGirl.create(:user)

  visit "/sign_in"
  fill_in("session_email", with: @current_user.email)
  fill_in("session_password", with: "secret")
  click_button("Log in")
  expect(page).to have_content "Logged in as #{@current_user.first_name}"
end

Given(/^I have a result for "(.*?)"$/) do |race_name|
  race = FactoryGirl.create(:race, name: race_name)
  result = FactoryGirl.create(:result, race: race, user: @current_user)
end