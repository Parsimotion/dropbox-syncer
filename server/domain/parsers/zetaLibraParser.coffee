_ = require("lodash")
Adjustment = require("producteca-sdk").Sync.Adjustment

module.exports =

class ZetaLibraParser
  getAjustes: ({stocks, prices}) ->
    stocks = @_sumBatches stocks

    _(stocks)
      .union prices
      .groupBy "CodigoArticulo"
      .values()
      .filter (pair) => pair.length is 2
      .map @_combine
      .value()

  _sumBatches: (stocks) =>
    _(stocks)
      .groupBy "CodigoArticulo"
      .values()
      .map @_sumBatch
      .flatten()
      .value()

  _sumBatch: (batch) =>
    stock = _(batch)
      .map (b) => parseInt b.Stock
      .sum()
    [ _.assign _.first(batch), Stock: "#{stock}" ]

  _combine: (pair) =>
    it = _.assign _.first(pair), _.last(pair)

    new Adjustment
      identifier: it.CodigoArticulo
      price: it.PrecioConIVA
      stock: it.Stock
