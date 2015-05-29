app.factory "Settings", ($resource) ->
  arrayToObject = (settings, property) ->
    settings[property] = _.reduce settings[property], ((acum, {original, parsimotion}) -> acum[original] = parsimotion; acum), {}

  objectToArray = (settings, property) ->
    settings[property] = _.map settings[property], (value, key) ->
      original: key
      parsimotion: value

  $resource "/api/settings", {},
    query:
      isArray: false
      transformResponse: (data) ->
        JSON.parse data

    parsers:
      method: "GET"
      url: "/api/settings/parsers"
      isArray: true

    update:
      method: "PUT"
