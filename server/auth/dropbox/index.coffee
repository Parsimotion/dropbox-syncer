"use strict"
express = require("express")
passport = require("passport")
auth = include("auth/auth.service")

router = express.Router()

router

.get "/", passport.authenticate("dropbox-oauth2")

.get "/callback", passport.authenticate("dropbox-oauth2",
  successRedirect: "/",
  failureRedirect: "/"
)

module.exports = router
