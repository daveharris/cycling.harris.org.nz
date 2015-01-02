Feature: Results

  Background:
    Given I am logged in
    Given I have a result for "Taupo Cycle Challenge"
    Given I have a result for "Tour of Wairarapa"

  Scenario: Lists all results
    When I visit "/results"
    Then I should see a link to "Taupo Cycle Challenge"
    And I should see a link to "Tour of Wairarapa"

  Scenario: Filter results by race
    When I filter results by user "" and race "Taupo Cycle Challenge"
    Then "Taupo Cycle Challenge" should be selected for "select#result_race_id"
    Then I should see a link to "Taupo Cycle Challenge"
    And I should not see a link to "Tour of Wairarapa"

  Scenario: Filter results by user
    When I filter results by user "John Smith" and race ""
    Then "John Smith" should be selected for "select#result_user_id"
    Then I should see a link to "Taupo Cycle Challenge"
    And I should see a link to "Tour of Wairarapa"

  Scenario: Filter results by user and race
    When I filter results by user "John Smith" and race "Taupo Cycle Challenge"
    Then "Taupo Cycle Challenge" should be selected for "select#result_race_id"
    Then "John Smith" should be selected for "select#result_user_id"
    And I should see a link to "Taupo Cycle Challenge"
    And I should not see a link to "Tour of Wairarapa"
