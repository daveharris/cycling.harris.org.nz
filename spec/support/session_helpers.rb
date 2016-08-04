module Features
  module SessionHelpers
    def login_as(user)
      user.update!(password: 'password')
      visit sign_in_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end
  end
end

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end
