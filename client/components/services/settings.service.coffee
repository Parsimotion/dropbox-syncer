app.factory "Settings", ($resource) ->
  $resource "/api/settings", {},
    query:
      isArray: false
      transformResponse: (data) ->
        settings = JSON.parse data
        settings

    parsers:
      method: "GET"
      url: "/api/settings/parsers"
      isArray: true

    update:
      method: "PUT"
      transformRequest: (settings) ->
        JSON.stringify settings
