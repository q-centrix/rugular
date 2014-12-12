Feature: Rugular CLI
  In order to generate an application route
  As a user of the rugular framework
  I want to bootstrap the templates necessary to carry this out

  Scenario: Generating a route
    When I set up Rugular and run "rugular generate route test"
    And the file "my-app/src/app/test/test.controller.coffee" should contain:
      """
      angular.module('test').controller('testController', testController)
      """
    And the file "my-app/src/app/test/test.routes.coffee" should contain:
      """
      angular.module('test').config(testRouting)
      """
    And the file "my-app/src/app/test/test.controller.spec.coffee" should contain:
      """
      describe 'testController', ->
      """
    And the file "my-app/src/app/test/test.haml" should contain:
      """
      %h1 test
      """
    And the file "my-app/src/app/app.module.coffee" should contain:
      """
      'test'
      """
    And the file "my-app/src/app/test/test.module.coffee" should contain:
      """
      angular.module 'test', [
        'ui.router'
      ]
      """

  Scenario: Generating a route in the components directory
    When I set up Rugular and run "rugular generate route -c test"
    And the file "my-app/src/components/test/test.controller.coffee" should contain:
      """
      angular.module('test').controller('testController', testController)
      """
