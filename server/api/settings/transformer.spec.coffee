_ = require("lodash")

Transformer = require("./transformer")
User = require("../user/user.model")

shouldHaveProperties = (object, properties, path = []) ->
  for name, expected of properties
    actual = object[name]
    if _.isObject expected
      shouldHaveProperties actual, expected, path.concat name
    else
      actual.should.eql expected, "Expected property '#{path.join(".") + "." + name}' to be #{expected} but was #{actual}"

describe "Settings transformer", ->
  it "puede convertir el modelo en DTO", ->
    user =
      syncer:
        settings:
          parser: "excel2003"
          fileName: "MER.xls"
          columns:
            sku: "REF"

      tokens:
        parsimotion: "12345678"

      settings:
        identifier: "sku"
        saved: true
        synchro: prices: false, stocks: true
        priceList: "Meli"
        warehouse: "Default"

    (Transformer.toDto user).should.eql
      saved: true
      identifier: "sku"
      parser:
        name: "excel2003"
      columns:
        sku: "REF"
      fileName: "MER.xls"
      parsimotionToken: "12345678"
      priceList: "Meli"
      warehouse: "Default"
      synchro: prices: false, stocks: true

  it "puede inyectar los valores del dto en el modelo", ->
    dto =
      parser:
        name: "excel2003"
      fileName: "MER.xls"
      parsimotionToken: "12345678"
      priceList: "Meli"
      warehouse: "Default"

    user = new User()
    Transformer.updateModel user, dto

    shouldHaveProperties user,
      syncer:
        settings:
          parser: "excel2003"
          fileName: "MER.xls"

      tokens:
        parsimotion: "12345678"

      settings:
        priceList: "Meli"
        warehouse: "Default"

  describe "al inyectar el modelo, ignora las properties que", ->
    dto = null
    user = null

    beforeEach ->
      dto =
        parser:
          name: "excel2003"

      user = new User()
      user.set "syncer.settings.fileName", "STOCK.xls"

    it "no estan definidas", ->
      Transformer.updateModel user, dto

      shouldHaveProperties user,
        syncer:
          settings:
            parser: "excel2003"
            fileName: "STOCK.xls"

    it "son nulas", ->
      dto.fileName = null

      Transformer.updateModel user, dto

      shouldHaveProperties user,
        syncer:
          settings:
            parser: "excel2003"
            fileName: "STOCK.xls"
