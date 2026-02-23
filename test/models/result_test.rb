require "test_helper"

class ResultTest < ActiveSupport::TestCase
  test "is invalid when duplicate result exists for same race and year" do
    original = Result.first
    duplicate = original.dup
    duplicate.user = original.user
    duplicate.race = original.race
    duplicate.date = original.date

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:user_id].join, "already recorded"
  end
end
