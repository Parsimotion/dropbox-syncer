'use strict'

<<<<<<< HEAD
window.app = angular.module 'dropbox-syncer-app', [
=======
window.app = angular.module 'integration-seed-app', [
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
<<<<<<< HEAD
  'rx'
=======
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true
