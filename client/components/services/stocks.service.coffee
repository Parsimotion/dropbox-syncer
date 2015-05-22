app.factory "Stock", ($resource) ->
  $resource "/api/adjustments", {},
    query:
      isArray: false
