_ = require("lodash")

Promise = require("bluebird")
ProductecaApi = require("producteca-sdk").Api
Syncer = require("producteca-sdk").Sync.Syncer
Parsers = require("./parsers/parsers")
config = include("config/environment")
excel2003OrdersParser = include("domain/parsers/orders/excel2003OrdersParser")
# revisarlos

module.exports =

# Sincroniza pedidos de Producteca a través de un archivo Xls obtenido de Dropbox
class Xls2Orders
  constructor: (@user, @settings) ->
    @productecaApi = new ProductecaApi
      accessToken: @user.tokens.producteca
      url: config.producteca.uri

  sync: =>
    console.log "Mirá mirá cómo le sincronizo con el archivo #{@settings.fileName}"
    @user.lastSync = { date: Date.now() }
    @user.save()
    @getAjustes()

  getAjustes: =>
    new Promise (resolve) => resolve
      date: Date.now()
      ajustes: [], linked: [], unlinked: []
