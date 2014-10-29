Q = require("q")

FixedLengthParser = require("../../domain/parsers/fixedLengthParser")
Syncer = require("../../domain/syncer")
ParsimotionClient = require("../../domain/parsimotionClient")

respond = (res, promise) ->
  promise.then ((data) -> res.send 200, data), (error) -> res.send 500, error

exports.stocks = (req, res) ->
  respond res, req.user.getSyncer().getStocks(),

exports.sync = (req, res) ->
  respond res, req.user.getSyncer().sync()
