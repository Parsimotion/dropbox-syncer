"use strict"
express = require("express")
controller = require("./adjustments.controller.coffee")
auth = include("auth/auth.service")

router = express.Router()

router.get "/", auth.authenticated, controller.adjustments
router.post "/", auth.authenticated, controller.sync

module.exports = router
