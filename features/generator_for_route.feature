Feature: Rugular CLI
  In order to generate an application route
  As a user of the rugular framework
  I want to bootstrap the templates necessary to carry this out

  Scenario: Generating a route
    When I set up Rugular and run "rugular generate route test"
    Then the file "my-app/src/app/test/test.controller.coffee" should contain:
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
    And a file named "my-app/src/app/test/_test.sass" should exist
    And the file "my-app/src/application.sass" should contain:
      """
      @import 'app/test'
      """

  Scenario: Generating a route in the components directory
    When I set up Rugular and run "rugular generate route -c test"
    Then the file "my-app/src/components/test/test.controller.coffee" should contain:
      """
      angular.module('test').controller('testController', testController)
      """

  Scenario: Generating a multiple word route
    When I set up Rugular and run "rugular generate route credit_card"
    Then the file "my-app/src/app/credit_card/credit_card.controller.coffee" should contain:
      """
      angular.module('creditCard').controller('creditCardController', creditCardController)
      """

  Scenario: Generating a nested route
    When I set up Rugular and run "rugular generate route profile; rugular generate route profile:address"
    Then the file "my-app/src/app/profile/address/address.controller.coffee" should contain:
      """
      angular.module('address').controller('addressController', addressController)
      """
    And the file "my-app/src/app/profile/address/address.routes.coffee" should contain:
      """
      angular.module('address').config(addressRouting)
      """
    And the file "my-app/src/app/profile/profile.module.coffee" should contain:
      """
      'address'
      """
    And the file "my-app/src/app/profile/address/address.module.coffee" should contain:
      """
      angular.module 'address', [
        'ui.router'
      ]
      """

  Scenario: Generating a doubly nested route
    When I set up Rugular and run "rugular generate route profile; rugular generate route profile:address; rugular generate route profile:address:zip_code"
    Then the file "my-app/src/app/profile/address/zip_code/zip_code.controller.coffee" should contain:
      """
      angular.module('zipCode').controller('zipCodeController', zipCodeController)
      """
    And the file "my-app/src/app/profile/address/zip_code/zip_code.routes.coffee" should contain:
      """
      angular.module('zipCode').config(zipCodeRouting)
      """
    And the file "my-app/src/app/profile/address/address.module.coffee" should contain:
      """
      'zipCode'
      """
