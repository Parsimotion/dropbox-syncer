'use strict'

angular.module 'parsimotionSyncerApp'
.controller 'SettingsCtrl', ($scope, Settings) ->
  $scope.parsers = Settings.parsers()
  $scope.settings = Settings.query()

  $scope.save = (form) ->
    $scope.submitted = true

    if form.$valid
      Settings.update $scope.settings
      .then ->
        $scope.message = 'Configuración actualizada!'
      .catch ->
        $scope.message = 'Hubo un error :('
