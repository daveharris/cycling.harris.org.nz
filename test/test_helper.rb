ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module LoginHelper
  def sign_in_as(user, password: "password")
    post "/session", params: {
      email_address: user.email_address,
      password: password
    }
    follow_redirect!
  end
end

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include LoginHelper
end
