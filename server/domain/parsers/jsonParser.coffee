Adjustment = require("producteca-sdk").Sync.Adjustment

module.exports =
  class JsonParser
    getAjustes: (data) ->
      JSON.parse(data).map (ajuste) ->
        new Adjustment ajuste
