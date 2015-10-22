'use strict'

app.controller 'MainCtrl', ($scope, $http, $window, Adjustment, Settings, Auth) ->
  actualizarEstado = (ajustes, estado) ->
    ajustes.forEach (ajuste) ->
      _.find($scope.ajustes.ajustes, identifier: ajuste.identifier).estadoSincronizacion = estado

  $scope.ajustes = Adjustment.query()
  $scope.settings = Settings.query()
  $scope.getCurrentUser = Auth.getCurrentUser

  $scope.getCurrentUser().$promise.then (user) ->
    $scope.lastSync = _.assign(user.lastSync, {
      linked: [1 .. user.lastSync.linked ]
      unlinked: [ 1 .. user.lastSync.unlinked ]
    })

  $scope.sincronizar = ->
    $scope.isSincronizando = true

    $http.post("/api/adjustments").success (resultadoSincronizacion) ->
      $scope.lastSync = resultadoSincronizacion
      $scope.isSincronizando = false

      actualizarEstado resultadoSincronizacion.linked, "ok"
      actualizarEstado resultadoSincronizacion.unlinked, "error"

  $scope.loginOauth = (provider) ->
    $window.location.href = '/auth/' + provider
