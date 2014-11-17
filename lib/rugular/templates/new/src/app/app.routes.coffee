AppRouting = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/')

  $stateProvider.state 'root',
    url: '/'
    templateUrl: './app/index.html'
    controller: 'AppController'
    controllerAs: 'app'

  return

AppRouting.$inject = ['$stateProvider', '$urlRouterProvider']

angular.module('app').config(AppRouting)

