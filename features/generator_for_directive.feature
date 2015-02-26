Feature: Rugular CLI
  In order to generate an application route
  As a user of the rugular framework
  I want to bootstrap the templates necessary to carry this out

  Scenario: Generating a route
    When I set up Rugular and run "rugular generate directive test"
    Then the file "my-app/src/components/test/test.directive.coffee" should contain:
      """
      angular.module('test').directive('test', test)
      """
    And the file "my-app/src/components/test/test.directive.spec.coffee" should contain:
      """
      describe 'testController', ->
      """
    And the file "my-app/src/components/test/test.haml" should contain:
      """
      %h1 test
      """
    And the file "my-app/src/app/app.module.coffee" should contain:
      """
      'test'
      """
    And the file "my-app/src/components/test/test.module.coffee" should contain:
      """
      angular.module 'test', [
      ]
      """
