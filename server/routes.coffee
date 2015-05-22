###*
Main application routes
###
"use strict"
errors = require("./components/errors")
module.exports = (app) ->

  # Insert routes below
  app.use "/api/files", require("./api/file")
  app.use "/api/users", require("./api/user")
  app.use "/api/adjustments", require("./api/adjustments")
  app.use "/api/hooks/dropbox", require("./api/hooks/dropbox")
  app.use "/api/hooks/webjob", require("./api/hooks/webjob")
  app.use "/api/settings", require("./api/settings")
  app.use "/auth", require("./auth")

  # All undefined asset or api routes should return a 404
  app.route("/:url(api|auth|components|app|bower_components|assets)/*").get errors[404]

  # All other routes should redirect to the index.html
  app.route("/*").get (req, res) ->
    res.sendfile app.get("appPath") + "/index.html"
    return

  return
