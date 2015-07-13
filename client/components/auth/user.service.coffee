'use strict'

<<<<<<< HEAD
angular.module 'dropbox-syncer-app'
=======
angular.module 'integration-seed-app'
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
.factory 'User', ($resource) ->
  $resource '/api/users/:id/:controller',
    id: '@_id'
  ,
    get:
      method: 'GET'
      params:
        id: 'me'

