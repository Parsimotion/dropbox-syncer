passport = require("passport")
DropboxOAuth2Strategy = require("passport-dropbox-oauth2").Strategy

exports.setup = (User, config) ->
  passport.use new DropboxOAuth2Strategy
    clientID: config.dropbox.clientID
    clientSecret: config.dropbox.clientSecret
    callbackURL: config.dropbox.callbackURL
    passReqToCallback: true
  , (req, accessToken, refreshToken, profile, done) ->
    User.findOne { _id: req.user._id }, (err, user) ->
      return done "the user is not logged in" if err

      setTokenAndSave = =>
        user.dropboxId = profile.id
        user.tokens.dropbox = accessToken
        user.save() ; user
      return done null, setTokenAndSave()
