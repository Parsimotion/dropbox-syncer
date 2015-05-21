'use strict'

app.controller 'SettingsCtrl', ($scope, $state, observeOnScope, Settings, Producteca) ->
  $scope.parsers = Settings.parsers()
  $scope.settings = Settings.query()
  $scope.settings.$promise.then (settings) =>
    if not settings.saved
      settings.synchro = stocks: true, prices: true

  $state.go "settings.tokens"

  Producteca.then (Producteca) =>
    observeOnScope $scope, "settings.parsimotionToken"
    .filter ({newValue}) -> newValue?
    .map ({newValue}) -> new Producteca newValue
    .subscribe (producteca) ->
      $scope.user = producteca.user()
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

    if form.$valid
      $scope.settings.saved = true
      Settings.update($scope.settings).$promise
      .then ->
        $scope.message = 'Configuración actualizada!'
      .catch ->
        $scope.message = 'Hubo un error :('
