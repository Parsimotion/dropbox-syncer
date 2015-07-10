app.factory "Adjustment", ($resource) ->
  $resource "/api/adjustments", {},
    query:
      isArray: false
