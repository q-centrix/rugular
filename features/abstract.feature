@increase_wait_time
Feature: Rugular CLI
  In order to abstract bower components
  As a user of the rugular framework
  I want to create a bower_component from any component folder

  Scenario: Abstract
    When I set up Rugular and run "rugular g directive test"
    And I run `cd tmp/aruba/my-app && rugular abstract test` interactively
    And I type 'yes'
    Then the file "~/bower_components/test/bower.json" should contain:
    """
    "private": true,
    """


