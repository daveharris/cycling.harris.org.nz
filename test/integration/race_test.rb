require "test_helper"

class RacesTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as(users(:dave))
  end

  test "race slug" do
    race = races(:featherston)

    assert_equal "/races/wairarapa-cycle-challenge-featherston-80", race_path(race)
    get race_url(race)

    assert_response :success
    assert_match race.name, response.body
  end
end
