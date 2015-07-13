Promise = require("bluebird")
ProductecaApi = require("producteca-sdk").Api
DropboxClient = require("dropbox").Client
config = include("config/environment")
_ = require("lodash")

module.exports =

# Sincroniza pedidos de Producteca a través de un archivo Xls obtenido de Dropbox
class DropboxXls2Orders
  constructor: (@user, @settings) ->
    @dropboxClient = Promise.promisifyAll new DropboxClient token: @user.tokens.dropbox
    @productecaApi = new ProductecaApi
      accessToken: @user.tokens.producteca
      url: config.producteca.uri

  sync: =>
    console.log "Mirá mirá cómo le sincronizo con el archivo #{@settings.fileName}"
    @getOrders().then (orders) =>
      console.log orders

    @user.lastSync = { date: Date.now() }
    @user.save() ; @getAjustes()

  getOrders: =>
    @dropboxClient
      .readFileAsync @settings.fileName, binary: true
      .then (data) => @_getParser().getOrders data[0]

  # Ajustes dummy para mantener la interfaz
  getAjustes: =>
    new Promise (resolve) => resolve
      date: Date.now()
      ajustes: [], linked: [], unlinked: []

  _getParser: => new (require("./parsers/orders/excel2003OrdersParser")) @settings
