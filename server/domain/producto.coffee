_ = require("lodash")

module.exports =

class Producto
  constructor: (properties) ->
    _.extend @, properties

  hasVariantes: =>
    _.size @variations > 1

  getVarianteParaAjuste: (ajuste) =>
    _.find @variations, (it) => it.barcode is ajuste.sku

  firstVariante: =>
    _.head @variations
