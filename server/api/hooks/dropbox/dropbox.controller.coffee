_ = require("lodash")
crypto = require("crypto")

config = include("config/environment")
User = include("api/user/user.model")

exports.challenge = (req, res) ->
  res.send 200, req.query.challenge

exports.notification = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  res.send 200
  User.findAsync({ provider: "dropbox", providerId: { $in: req.body.delta.users } })
    .then (users) ->
      console.log "Synchronizing from Dropbox..."
      users.forEach (it) -> it.getDataSource().sync()
    .catch (err) ->
      throw new Error "Can't retrieve the users"

isSignatureValid = (req) ->
  req.headers["x-dropbox-signature"] == crypto.createHmac('SHA256', config.dropbox.clientSecret).update(req.rawBody).digest('hex')
