"use strict"
express = require("express")
controller = require("./settings.controller.coffee")
auth = include("auth/auth.service")

router = express.Router()

router.get "/parsers", controller.availableParsers
router.get "/env", controller.env
router.get "/", auth.authenticated, controller.index
router.put "/", auth.authenticated, controller.update

module.exports = router
