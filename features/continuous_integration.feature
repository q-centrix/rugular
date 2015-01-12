Feature: Rugular CLI
  In order to run the tests in the continuous integration environment
  As a developer of an application
  I want to run the tests once

  Scenario: Running the tests for continuous integration
    When I set up Rugular with dependencies and run "rugular ci"
    Then the exit status should not be 1
