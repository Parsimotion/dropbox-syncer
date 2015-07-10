"use strict"
express = require("express")
controller = require("./file.controller")
auth = include("auth/auth.service")

router = express.Router()

router.get "/", auth.authenticated, controller.index

module.exports = router
