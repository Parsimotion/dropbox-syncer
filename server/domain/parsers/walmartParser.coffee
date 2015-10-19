JsonParser = require("./jsonParser")
_ = require("lodash")

module.exports =
  class WalmartParser extends JsonParser
    getAjustes: (data) ->
      console.log '---------------------------------------------'
      super data.replace /wol\/\d+\..../g, (path) ->
        id = path.match /\d+/
        extension = _.last path.split /\./
        'meli/' + id + '-1.' + extension