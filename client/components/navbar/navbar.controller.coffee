'use strict'

angular.module 'dropbox-syncer-app'
.controller 'NavbarCtrl', ($scope, $location, Auth) ->
  $scope.menu = [
    title: 'Inicio'
    link: '/'
  ,
    title: 'Historial'
    link: '/history'
  ]
  $scope.isCollapsed = true
  $scope.getCurrentUser = Auth.getCurrentUser

  $scope.isActive = (route) ->
    route is $location.path()

  $scope.logout = ->
    window.location = "/logout"
