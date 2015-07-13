'use strict'

<<<<<<< HEAD
angular.module 'dropbox-syncer-app'
=======
angular.module 'integration-seed-app'
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
.factory 'Auth', ($location, $rootScope, $http, User, $cookieStore, $q) ->
  currentUser = User.get()

  ###
  Gets all available info on authenticated user

  @return {Object} user
  ###
  getCurrentUser: ->
    currentUser
