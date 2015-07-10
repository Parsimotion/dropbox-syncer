'use strict'

angular.module 'dropbox-syncer-app'
.config ($stateProvider) ->
  $stateProvider
  .state 'history',
    url: '/history'
    templateUrl: 'app/history/history.html'
    controller: 'HistoryCtrl'
