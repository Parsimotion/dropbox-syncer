'use strict'

<<<<<<< HEAD
angular.module 'dropbox-syncer-app'
=======
angular.module 'integration-seed-app'
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
.config ($stateProvider) ->
  $stateProvider
  .state 'main',
    url: '/'
    templateUrl: 'app/main/main.html'
    controller: 'MainCtrl'
