'use strict'

<<<<<<< HEAD
app.controller 'SettingsCtrl', ($scope, $state, observeOnScope, Settings, Producteca) ->
  $scope.parsers = Settings.parsers()
  $scope.settings = Settings.query()
  $scope.settings.$promise.then (settings) =>
    if not settings.saved
      settings.synchro = stocks: true, prices: true
      settings.identifier = "barcode"

  $state.go "settings.syncer"

  Producteca.then (Producteca) =>
    observeOnScope $scope, "settings.productecaToken"
    .filter ({newValue}) -> newValue?
    .map ({newValue}) -> new Producteca newValue
    .subscribe (producteca) ->
      $scope.priceLists = producteca.priceLists()
      $scope.warehouses = producteca.warehouses()

  $scope.irAPasoSiguienteSyncer = ->
    nextState =
      if $scope.settings.parser.name is "excel2003"
        "columnasExcel"
      else
        "producteca"

    $state.go "settings.#{nextState}"

  $scope.irAPasoSiguienteExcel = ->
    $state.go "settings.producteca"

  $scope.parseExcel = (xls) ->
    firstSheet = (workbook) -> workbook.Sheets[workbook.SheetNames[0]]
    toWorkbook = (xlsBinary) -> XLS.read xlsBinary, type: "binary"
    parse = _.compose XLS.utils.sheet_to_json, firstSheet, toWorkbook

    $scope.columnasExcelRequeridas = ["sku", "nombre", "precio", "stock"]
    $scope.datosExcel = parse xls
    $scope.ejemploFilasExcel = _.take $scope.datosExcel, 5
    $scope.primeraFilaExcel = _.head $scope.ejemploFilasExcel
    $scope.columnasExcel = _.keys $scope.primeraFilaExcel

  $scope.save = (form) ->
    #$scope.submitted = true #saco esto porque
    #hay una condición de carrera en localhost que
    #desactiva antes de tiempo el botón de guardar
=======
app.controller 'SettingsCtrl', ($scope, $state, Settings, Producteca) ->
  $scope.settings = Settings.query()

  $state.go "settings.step1"
  $scope.settings.$promise.then (settings) =>
    if not settings.saved
      ;
      # set to settings some default values

  $scope.save = (form) ->
    $scope.submitted = true
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b

    if form.$valid
      $scope.settings.saved = true
      Settings.update($scope.settings).$promise
      .then ->
        $scope.message = 'Configuración actualizada!'
      .catch ->
        $scope.message = 'Hubo un error :('
