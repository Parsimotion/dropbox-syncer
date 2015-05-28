_ = require("lodash")
Adjustment = require("producteca-sdk").Sync.Adjustment

module.exports = class FixedLengthParser
  getAjustes: (data) ->
    _(data.split /\r\n|\r|\n/)
      .reject _.isEmpty
      .map @_parseRow
      .value()

  _parseRow: (row) =>
    new Adjustment (_.zipObject [ "identifier", "name", "price", "stock" ], @_getFields row)

  _getFields: (row) ->
    _.drop row.match /^(.{30})(.{50})(.{15})(.{10})$/
