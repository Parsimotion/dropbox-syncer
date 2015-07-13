"use strict"
express = require("express")
controller = require("./settings.controller.coffee")
auth = include("auth/auth.service")

router = express.Router()

<<<<<<< HEAD
router.get "/parsers", controller.availableParsers
=======
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
router.get "/env", controller.env
router.get "/", auth.authenticated, controller.index
router.put "/", auth.authenticated, controller.update

module.exports = router
