_ = require("lodash")

module.exports =

class Producto
  constructor: (properties) ->
    _.extend @, properties

  hasVariantes: =>
    _.size @variations > 1

  getVarianteParaAjuste: (ajuste, settings) =>
    #todo: modificar para bancar varias variantes (cuak)
    _.head @variations
