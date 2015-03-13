@increase_wait_time
Feature: Rugular CLI
  In order to generate initial files
  As a user of the rugular framework
  I want bootstrap the files necessary to start hacking!

  Scenario: New
    When I run `rugular new my-app`
    Then the exit status should be 0
    And the file "my-app/.gitignore" should contain:
      """
      bower_components
      """
    And the file "my-app/bower.json" should contain:
      """
      "name": "my-app",
      """
    And the file "my-app/package.json" should contain:
      """
      "name": "my-app",
      """
    And the file "my-app/karma.conf.js" should contain:
      """
      frameworks: ['jasmine', 'sinon'],
      """
    And the file "my-app/src/index.haml" should contain:
      """
      %title my-app
      """
    And the file "my-app/.application.sass" should contain:
      """
      @import "vendor/bourbon/bourbon"
      """
    And a directory named "my-app/vendor/bourbon" should exist
    And a directory named "my-app/vendor/neat" should exist
    And a directory named "my-app/vendor/base" should exist
    And a directory named "my-app/src/components" should exist
    And the output should contain "Thank you for installing Rugular"

