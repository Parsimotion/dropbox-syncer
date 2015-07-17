Promise = require("bluebird")
ProductecaApi = require("producteca-sdk").Api
DropboxClient = require("dropbox").Client
config = include("config/environment")
_ = require("lodash")

module.exports =

# Sincroniza pedidos de Producteca a través de un archivo Xls obtenido de Dropbox, con el formato de woOw
class WoOw
  constructor: (@user, @settings) ->
    @dropboxClient = Promise.promisifyAll new DropboxClient token: @user.tokens.dropbox
    @productecaApi = new ProductecaApi
      accessToken: @user.tokens.producteca
      url: config.producteca.uri

  sync: =>
    # row = { id, pagado, entregado, idwoOw }
    @getOrders().then (rows) =>
      console.log rows

      Promise.settle(rows.map @syncRow)
        .then (results) =>
          linked = results
            .filter (result) => result.isFulfilled()
            .map (result) => result.value()
          unlinked = _(rows).map("id").difference(linked).value()

          @user.lastSync = { date: Date.now() }
          @user.save()

          { linked, unlinked }

  syncRow: (row) =>
    @productecaApi.getSalesOrder(row.id).then (salesOrder) =>
      updateNotes = =>
        @productecaApi.updateSalesOrder row.id, notes: "#{row.idwoOw}"

      doPayment = =>
        alreadyPaid = _.sum salesOrder.payments, "amount"
        pendingPayment = salesOrder.amount - alreadyPaid

        if row.pagado and pendingPayment > 0
          @_doRequest "post", "/salesorders/#{row.id}/payments",
            amount: pendingPayment
            method: "Cash"
        else Promise.resolve()

      doShipment = =>
        if row.entregado and _.isEmpty(salesOrder.shipments)
          @_doRequest "post", "/salesorders/#{row.id}/shipments",
            method: status: "Done"
            products: salesOrder.lines.map (line) =>
              quantity: line.quantity
              variation: line.variation.id
        else Promise.resolve()

      updateNotes().then =>
        console.log "Order #{row.id}: notes ok"
        doPayment().then =>
          console.log "Order #{row.id}: payment ok"
          doShipment().then =>
            console.log "Order #{row.id}: shipment ok"
            row.id

  getOrders: =>
    @dropboxClient
      .readFileAsync @settings.fileName, binary: true
      .then (data) => @_getParser().getOrders data[0]

  getAjustes: =>
    @getOrders().then (data) =>
      date: Date.now()
      ajustes:
        data.map (row) =>
          identifier: row.id
          name: row.idwoOw
          price: if row.pagado then 1 else 0
          stock: if row.entregado then 1 else 0

  _doRequest: (verb, resource, body) =>
    returnOne = (promise) => promise.spread (req, res, obj) -> obj
    returnOne(@productecaApi.client["#{verb}Async"] resource, body)

  _getParser: => new (require("./parsers/others/excel2003SimpleParser")) @settings
