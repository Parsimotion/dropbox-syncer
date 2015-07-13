"use strict"
passport = require("passport")
config = include("config/environment")
User = include("api/user/user.model")

exports.authenticated = (req, res, next) ->
  reject = -> res.send 401

  if req.isAuthenticated()
<<<<<<< HEAD
    User.findOneAsync(req.user._id)
=======
    # find the last version of the user in the db
    User.findOneAsync(_id: req.user._id)
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
      .then (user) -> req.user = user ; next()
      .catch reject
  else reject()

exports.logout = (req, res) ->
  req.logout()
  res.redirect "/"
