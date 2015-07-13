<<<<<<< HEAD
Parsers = include("domain/parsers/parsers")
Exhibitor = include("domain/utils/exhibitor")

=======
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
Transformer = require("./transformer")
config = include("config/environment")

exports.index = (req, res) ->
  res.send 200, Transformer.toDto req.user

exports.env = (req, res) ->
  res.send 200, { apiUrl: config.producteca.uri }

exports.update = (req, res) ->
  Transformer.updateModel req.user, req.body
  req.user.save (err) ->
    if err then res.json 400, err else res.send 200
<<<<<<< HEAD

exports.availableParsers = (req, res) ->
  res.send 200, new Exhibitor(Parsers).getFields()
=======
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
