"use strict"

express = require("express")
config = include("config/environment")
User = include("api/user/user.model")

# Passport Configuration
require("./passport.serializer")
require("./producteca/passport").setup User, config
<<<<<<< HEAD
require("./dropbox/passport").setup User, config

router = express.Router()
router.use "/producteca", require("./producteca")
router.use "/dropbox", require("./dropbox")
=======

router = express.Router()
router.use "/producteca", require("./producteca")
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b

module.exports = router
