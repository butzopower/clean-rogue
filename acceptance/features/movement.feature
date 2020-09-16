Feature: Movement
  Scenario: Moving to the right
    Given I'm in a spacious room
    When I move right
    Then my character should move right

  Scenario: Bumping into stuff
    Given I'm in a room with obstacles
    When I move left
    Then my character should bump into an obstacle