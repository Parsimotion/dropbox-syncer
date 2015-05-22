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
    .map (ajustes, identifier) =>
      ajuste = _.head ajustes

      ajuste: ajuste
      productos: @_getProductosForAjuste ajuste
    .value()

    hasProductos = (it) => not _.isEmpty it.productos

    linked: _.filter join, hasProductos
    unlinked: _.reject join, hasProductos

  _updateStocksAndPrices: (ajustesYProductos) =>
    syncPrices = @settings.synchro.prices
    syncStocks = @settings.synchro.stocks

    ajustesYProductos.linked.map (it) =>
      productos = it.productos

      updateIf = (condition, update) =>
        if condition then productos.map update else []

      Q.all _.flatten [
        updateIf syncPrices, (p) => @_updatePrice it.ajuste, p
        updateIf syncStocks, (p) => @_updateStock it.ajuste, p
      ]
      .then =>
        ids: _.map productos, "id"
        sku: it.ajuste.sku

  _updatePrice: (ajuste, producto) =>
    console.log "Updating price of ~#{ajuste.sku}(#{producto.id}) with value $#{ajuste.precio}..."
    @productecaApi.updatePrice producto, @settings.priceList, ajuste.precio

  _updateStock: (ajuste, producto) =>
    variationId = @_getVariante(producto, ajuste).id

    console.log "Updating stock of ~#{ajuste.sku}(#{producto.id}, #{variationId}) with quantity #{ajuste.stock}..."
    @productecaApi.updateStocks
      id: producto.id
      warehouse: @settings.warehouse
      stocks: [
        variation: variationId
        quantity: ajuste.stock
      ]

  _getStock: (producto) =>
    stock = _.find (@_getVariante producto).stocks, warehouse: @settings.warehouse
    if stock? then stock.quantity else 0

  _getVariante: (producto, ajuste) =>
    producto.getVarianteParaAjuste(ajuste) || producto.firstVariante()

  _getProductosForAjuste: (ajuste) =>
    findBySku = => _.filter @productos, sku: ajuste.sku
    return findBySku() if @settings.identifier is "sku"

    matches = _(@productos)
      .filter (it) => it.getVarianteParaAjuste(ajuste)?
      .value()

    if _.isEmpty matches then findBySku()
    else matches
