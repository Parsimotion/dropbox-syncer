Q = require("q")
_ = require("lodash")

module.exports =

class Syncer
  constructor: (@productecaApi, @settings, @productos) ->

  execute: (ajustes) =>
    ajustesYProductos = @joinAjustesYProductos ajustes

    (Q.allSettled @_updateStocksAndPrices ajustesYProductos).then (resultados) =>
      _.mapValues ajustesYProductos, (ajustesYProductos) =>
        ajustesYProductos.map (it) => sku: it.ajuste.sku

  joinAjustesYProductos: (ajustes) =>
    join = _(ajustes)
    .filter "sku"
    .groupBy "sku"
    .map (variantes, sku) =>
      ajuste:
        sku: sku
        precio: (_.head variantes).precio
        stocks: variantes
      productos: @_getProductosForAjuste (_.head variantes)
    .value()

    hasProductos = (it) => not _.isEmpty it.productos

    linked: _.filter join, hasProductos
    unlinked: _.reject join, hasProductos

  _updateStocksAndPrices: (ajustesYProductos) =>
    synchroPrices = not @settings.synchro? or @settings.synchro?.prices
    synchroStocks = not @settings.synchro? or @settings.synchro?.stocks

    ajustesYProductos.linked.map (it) =>
      productos = it.productos
      Q.all _.flatten [
        if synchroPrices then productos.map (p) => @_updatePrice it.ajuste, p else []
        if synchroStocks then productos.map (p) => @_updateStock it.ajuste, p else []
      ]
      .then =>
        ids: _.map productos, "id"
        sku: it.ajuste.sku

  _updateStock: (ajuste, producto) =>
    @productecaApi.updateStocks
      id: producto.id
      warehouse: @settings.warehouse
      stocks: _.map ajuste.stocks, (it) =>
        variation: (@_getVariante producto, it).id
        quantity: it.stock

  _updatePrice: (ajuste, producto) =>
    @productecaApi.updatePrice producto, @settings.priceList, ajuste.precio

  _getStock: (producto) =>
    stock = _.find (@_getVariante producto).stocks, warehouse: @settings.warehouse
    if stock? then stock.quantity else 0

  _getVariante: (producto, ajuste) =>
    producto.getVarianteParaAjuste ajuste, @settings

  _getProductosForAjuste: (ajuste) =>
    _.filter @productos, sku: ajuste.sku
