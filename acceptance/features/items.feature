Feature: Items
  Scenario: Seeing an item on the ground
    Given I'm in a tiny room with an item
    When I move left
    And I look at the floor
    Then I should see an item