'use strict'

<<<<<<< HEAD
angular.module 'dropbox-syncer-app'
=======
angular.module 'integration-seed-app'
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
.controller 'NavbarCtrl', ($scope, $location, Auth) ->
  $scope.menu = [
    title: 'Inicio'
    link: '/'
<<<<<<< HEAD
  ,
    title: 'Historial'
    link: '/history'
  ]
  $scope.isCollapsed = true
=======
  ]
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
  $scope.getCurrentUser = Auth.getCurrentUser

  $scope.isActive = (route) ->
    route is $location.path()

  $scope.logout = ->
    window.location = "/logout"
