'use strict'

window.app = angular.module 'dropbox-syncer-app', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'rx'
]
.config ($stateProvider, $urlRouterProvider, $locationProvider, $httpProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true
