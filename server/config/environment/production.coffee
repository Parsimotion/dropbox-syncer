"use strict"

# Production specific configuration
# =================================
module.exports =

  # Server IP
  ip: process.env.OPENSHIFT_NODEJS_IP or process.env.IP or `undefined`

  # Server port
  port: process.env.OPENSHIFT_NODEJS_PORT or process.env.PORT or 8080

  # MongoDB connection options
  mongo:
<<<<<<< HEAD
    uri: process.env.MONGO_URI or process.env.MONGOHQ_URL or "mongodb://localhost/parsimotionsyncer"
=======
    uri: process.env.MONGO_URI or "mongodb://localhost/integration-seed"
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
    options:
      server:
        socketOptions:
          keepAlive: 1
      replset:
        socketOptions:
          keepAlive: 1
