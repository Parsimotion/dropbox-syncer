app.factory "Stock", ($resource) ->
  $resource "/api/stocks", {},
    query:
      isArray: false
      timeout: 600000
