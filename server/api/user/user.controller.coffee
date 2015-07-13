"use strict"
User = require("./user.model")
passport = require("passport")
config = include("config/environment")

###*
Get my info
###
exports.me = (req, res, next) ->
  res.json req.user
