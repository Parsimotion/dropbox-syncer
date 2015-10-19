JsonParser = require("./jsonParser")
_ = require("lodash")

module.exports =
  class WalmartParser extends JsonParser
    getAjustes: (data) =>
      ajustes = super data.replace /wol\/\d+\..../g, (path) ->
        id = path.match /\d+/
        extension = _.last path.split /\./
        'meli/' + id + '-1.' + extension
      ajustes.map @_evenOddToAjuste

    _evenOddToAjuste: (ajuste) =>
      ajuste.notes = @_evenOdd ajuste.notes
      ajuste

    _evenOdd: (notes) =>
      index = 0
      notes?.replace /<li>/g, (item) ->
        index += 1
        '<li class="' + (if index % 2 is 0 then 'even' else 'odd') + '">'
