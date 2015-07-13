"use strict"
passport = require("passport")
config = include("config/environment")
User = include("api/user/user.model")

exports.authenticated = (req, res, next) ->
  reject = -> res.send 401

  if req.isAuthenticated()
    # find the last version of the user in the db
    User.findOneAsync(_id: req.user._id)
      .then (user) -> req.user = user ; next()
      .catch reject
  else reject()

exports.logout = (req, res) ->
  req.logout()
  res.redirect "/"
