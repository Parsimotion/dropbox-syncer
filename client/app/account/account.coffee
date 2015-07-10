'use strict'

angular.module 'dropbox-syncer-app'
.config ($stateProvider) ->
  $stateProvider
  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'

  .state 'settings.syncer',
    url: '/syncer'
    templateUrl: 'app/account/settings/settings-syncer.html'

  .state 'settings.columnasExcel',
    url: '/columnasexcel'
    templateUrl: 'app/account/settings/settings-columnasExcel.html'

  .state 'settings.producteca',
    url: '/producteca'
    templateUrl: 'app/account/settings/settings-producteca.html'
