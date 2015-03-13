@increase_wait_time
Feature: Rugular CLI
  In order to abstract bower components
  As a user of the rugular framework
  I want to create a bower_component from my rugular application

  # Scenario: Abstracting components folder
  #   When I set up Rugular and run "rugular g directive test && rugular abstract -c"
  #   Then the file "my-app/bower.json" should contain:
  #   """
  #   "version": "0.0.0",
  #   """
  #   And a file named "my-app/release/my-app.js" should exist
  #   And a file named "my-app/release/my-app.css" should exist

  # Scenario: Abstracting both the app and components folder
  #   When I set up Rugular and run "rugular g directive test && rugular abstract"
  #   Then the file "my-app/bower.json" should contain:
  #   """
  #   "version": "0.0.0",
  #   """
  #   And a file named "my-app/release/my-app.js" should exist
  #   And a file named "my-app/release/my-app.css" should exist
  #
  Scenario: Abstracting both the app and components folder twice
    When I set up Rugular and run "rugular g directive test && rugular abstract && rugular abstract"
    Then the file "my-app/bower.json" should contain:
    """
    "0.0.1"
    """
    And a file named "my-app/release/my-app.js" should exist
    And a file named "my-app/release/my-app.css" should exist
