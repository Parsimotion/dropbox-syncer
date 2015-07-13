'use strict'

<<<<<<< HEAD
app.controller 'MainCtrl', ($scope, $http, $window, Adjustment, Settings, Auth) ->
  actualizarEstado = (ajustes, estado) ->
    ajustes.forEach (ajuste) ->
      _.find($scope.ajustes.ajustes, identifier: ajuste.identifier).estadoSincronizacion = estado

  $scope.ajustes = Adjustment.query()
  $scope.settings = Settings.query()
  $scope.getCurrentUser = Auth.getCurrentUser

  $scope.getCurrentUser().$promise.then (user) ->
    $scope.lastSync = user.lastSync

  $scope.sincronizar = ->
    $scope.isSincronizando = true

    $http.post("/api/adjustments").success (resultadoSincronizacion) ->
      $scope.lastSync = resultadoSincronizacion
      $scope.isSincronizando = false

      actualizarEstado resultadoSincronizacion.linked, "ok"
      actualizarEstado resultadoSincronizacion.unlinked, "error"

  $scope.loginOauth = (provider) ->
    $window.location.href = '/auth/' + provider
=======
app.controller 'MainCtrl', ($scope, $http, Auth) ->
  Auth.getCurrentUser().$promise?.then (user) ->
    #do something here
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
