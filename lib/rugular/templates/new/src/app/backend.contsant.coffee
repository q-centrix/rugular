# Do not change the contents of this file, it is used by Rugular
# to inject api endpoints as part of the build process
BACKEND =
  authentication_url: 'Declare the authentication_url in the config.yaml, Rugular will fill this in for you'
  authorization_url: 'Declare the authorization_url in the config.yaml, Rugular will fill this in for you'
  api_url: 'Declare the api_url in the config.yaml, Rugular will fill this in for you'

angular.module('app').constant('BACKEND', BACKEND)
