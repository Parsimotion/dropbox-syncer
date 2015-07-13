"use strict"
User = require("./user.model")
passport = require("passport")
config = include("config/environment")

###*
Get my info
###
exports.me = (req, res, next) ->
<<<<<<< HEAD
  res.json req.user
=======
  userId = req.user._id
  User.findOne _id: userId, (err, user) ->
    return next(err)  if err
    return res.json(401)  unless user
    res.json user
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
