@increase_wait_time
Feature: Rugular CLI
  In order to abstract bower components
  As a user of the rugular framework
  I want to create a bower_component from any component folder

  # Scenario: Abstracting components folder
  #   When I set up Rugular and run "rugular g directive test"
  #   And I run `cd tmp/aruba/my-app && rugular abstract -c`
  #   Then the file "~/bower_components/myapp/bower.json" should contain:
  #   """
  #   "private": true,
  #   """
  #
  # Scenario: Abstracting both the app and components folder
  #   When I set up Rugular and run "rugular g directive test"
  #   And I run `cd tmp/aruba/my-app && rugular abstract`
  #   Then the file "~/bower_components/myapp/bower.json" should contain:
  #   """
  #   "private": true,
  #   """
  #
  #
