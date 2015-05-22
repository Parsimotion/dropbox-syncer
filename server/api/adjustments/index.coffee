"use strict"
express = require("express")
controller = require("./adjustments.controller.coffee")
auth = require("../../auth/auth.service")

router = express.Router()

router.get "/", auth.isAuthenticated(), controller.adjustments
router.post "/", auth.isAuthenticated(), controller.sync

module.exports = router
