User = require("../../user/user.model")

exports.notification = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  User.findOneAsync(_id: req.body.userId)
    .then (user) =>
      user.getProductsSyncer().sync()
        .then (result) => res.send 200, result
    .catch (e) => res.send 400, e.message or e

isSignatureValid = (req) ->
  req.headers["signature"] is process.env.WEBJOB_SIGNATURE
