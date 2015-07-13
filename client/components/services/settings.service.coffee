app.factory "Settings", ($resource) ->
  $resource "/api/settings", {},
    query:
      isArray: false
      transformResponse: (data) ->
        settings = JSON.parse data
        settings

<<<<<<< HEAD
    parsers:
      method: "GET"
      url: "/api/settings/parsers"
      isArray: true

=======
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
    update:
      method: "PUT"
      transformRequest: (settings) ->
        JSON.stringify settings
