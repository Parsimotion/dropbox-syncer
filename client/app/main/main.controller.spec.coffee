describe 'MainCtrl', ->
  beforeEach ->
    inject ($q) ->
      getController "MainCtrl",
        Auth:
          getCurrentUser: ->
            $promise: $q.when {}

    $httpBackend.expectGET("/api/adjustments").respond 200,
      fecha: 461523123
      ajustes: [
        identifier: 1
      ,
        identifier: 2
      ]

    $httpBackend.expectGET("/api/settings").respond 200

    $httpBackend.flush()

  it 'al sincronizar, actualiza el estado de cada ajuste', ->
    $httpBackend.expectPOST("/api/adjustments").respond 200,
      linked: [ identifier: 1 ]
      unlinked: [ identifier: 2 ]

    $scope.sincronizar()

    $httpBackend.flush()

    expect($scope.ajustes.ajustes).toDeepEqual [
      identifier: 1, estadoSincronizacion: "ok"
    ,
      identifier: 2, estadoSincronizacion: "error"
    ]
