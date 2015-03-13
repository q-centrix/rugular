@increase_wait_time
Feature: Rugular CLI
  In order to create production files
  As a user of the rugular framework
  I want to create manifest js and css files

  Scenario: Building the dist folder
    When I set up Rugular and run "cd tmp/aruba/my-app && rugular build`
    Then a file named "tmp/aruba/myapp/dist/index.html" should exist
    Then a file named "tmp/aruba/myapp/dist/application.css" should exist
    Then a file named "tmp/aruba/myapp/dist/application.js" should exist
    Then a file named "tmp/aruba/myapp/dist/vendor.css" should exist
    Then a file named "tmp/aruba/myapp/dist/vendor.js" should exist

