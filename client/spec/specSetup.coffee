$httpBackend = null
$scope = null
getController = null

beforeEach ->
<<<<<<< HEAD
  module "dropbox-syncer-app"
=======
  module "integration-seed-app"
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b

  inject ($controller, $rootScope, _$httpBackend_, observeOnScope) ->
    $httpBackend = _$httpBackend_
    $scope = $rootScope.$new()

    getController = (name, dependencies) ->
      defaults = _.partialRight(_.assign, (a, b) ->
        (if typeof a is "undefined" then b else a)
      )

      defaultDependencies =
        $scope: $scope
        $httpBackend: $httpBackend
        observeOnScope: observeOnScope

      $controller name, (defaults defaultDependencies, dependencies)
