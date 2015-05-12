_ = require("lodash")
Q = require("q")
crypto = require("crypto")

config = require("../../../config/environment/index")
User = require("../../user/user.model")

exports.challenge = (req, res) ->
  res.send 200, req.query.challenge

exports.notification = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  res.send 200
  User.find().where("providerId").in(req.body.delta.users).exec (err, users) =>
    if err then throw new Error "Can't retrieve the users"

    console.log "Synchronizing from Dropbox..."
    users.forEach (it) -> it.getDataSource().sync()

isSignatureValid = (req) ->
  req.headers["x-dropbox-signature"] == crypto.createHmac('SHA256', config.dropbox.clientSecret).update(req.rawBody).digest('hex')
