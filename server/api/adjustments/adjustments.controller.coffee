Q = require("q")

respond = (res, promise) ->
  promise.then ((data) -> res.send 200, data), (error) -> throw error

exports.adjustments = (req, res) ->
  respond res, req.user.getDataSource().getAjustes()

exports.sync = (req, res) ->
  console.log "Synchronizing by user request..."
  respond res, req.user.getDataSource().sync()
