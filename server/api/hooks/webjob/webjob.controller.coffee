User = include("api/user/user.model")

exports.notification = (req, res) ->
  if not isSignatureValid req
    return res.send 403, "Invalid signature"

  User.findOneAsync(_id: req.body.userId)
    .then (user) =>
<<<<<<< HEAD
      console.log "Synchronizing from Job..."
      user.getDataSource().sync()
        .then (result) => res.send 200, result
=======
      res.send 200
      # do something in the webjob
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
    .catch (e) => res.send 400, e.message or e

isSignatureValid = (req) ->
  req.headers["signature"] is (process.env.WEBJOB_SIGNATURE or "default")
