###*
Main application routes
###
"use strict"
errors = require("./components/errors")
auth = require("./auth/auth.service")

module.exports = (app) ->
  home = (req, res) ->
    if req.isAuthenticated()
      res.sendfile app.get("appPath") + "/main.html"
    else
      res.sendfile app.get("appPath") + "/landing.html"

  # Insert routes below
  app.get "/", home
  app.use "/api/users", require("./api/user")
  app.use "/api/hooks/webjob", require("./api/hooks/webjob")
  app.use "/api/settings", require("./api/settings")
  app.use "/auth", require("./auth")
  app.get "/logout", auth.logout

<<<<<<< HEAD
  app.use "/api/files", require("./api/file")
  app.use "/api/adjustments", require("./api/adjustments")
  app.use "/api/hooks/dropbox", require("./api/hooks/dropbox")
  app.use "/api/hooks/webjob", require("./api/hooks/webjob")

=======
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
  # All undefined asset or api routes should return a 404
  app.route("/:url(api|auth|components|app|bower_components|assets)/*").get errors[404]

  # All other routes should redirect to the home
  app.route("/*").get home
