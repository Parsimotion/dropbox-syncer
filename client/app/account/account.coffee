'use strict'

<<<<<<< HEAD
angular.module 'dropbox-syncer-app'
=======
angular.module 'integration-seed-app'
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
.config ($stateProvider) ->
  $stateProvider
  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'

<<<<<<< HEAD
  .state 'settings.syncer',
    url: '/syncer'
    templateUrl: 'app/account/settings/settings-syncer.html'

  .state 'settings.columnasExcel',
    url: '/columnasexcel'
    templateUrl: 'app/account/settings/settings-columnasExcel.html'

  .state 'settings.producteca',
    url: '/producteca'
    templateUrl: 'app/account/settings/settings-producteca.html'
=======
  .state 'settings.step1',
    url: '/step1'
    templateUrl: 'app/account/settings/settings-step1.html'

  .state 'settings.step2',
    url: '/step2'
    templateUrl: 'app/account/settings/settings-step2.html'
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
