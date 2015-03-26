AppRouting = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise('/')

  $stateProvider.state 'root',
    url: '/'
    templateUrl: 'app/app.html'
    controller: 'appController'
    controllerAs: 'app'

AppRouting.$inject = ['$stateProvider', '$urlRouterProvider']

angular.module('app').config(AppRouting)

