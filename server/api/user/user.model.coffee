"use strict"

mongoose = require("mongoose")
Promise = require("bluebird")
Promise.promisifyAll mongoose

Schema = mongoose.Schema

authTypes = ["producteca"]

UserSchema = new Schema
  name: String
  email:
    type: String
    lowercase: true
    required: true
    unique: true

  provider: String
  providerId: Number
  dropboxId: Number

  tokens:
    producteca: String
    dropbox: String

  settings:
    saved: Boolean
    warehouse: String
    priceList: String
    identifier: String
    createProducts: Boolean
    synchro:
      prices: Boolean
      stocks: Boolean
      data: Boolean

  syncer:
    name:
      type: String
      default: "dropbox"
    settings: Schema.Types.Mixed

  lastSync:
    date: Date
    linked: Number
    unlinked: Number

###*
Methods
###
UserSchema.methods =
  getDataSource: -> S = @getDataSourceConstructor() ; new S @, @syncer.settings
  getDataSourceConstructor: -> include("domain/#{@syncer.name}")

module.exports = mongoose.model("User", UserSchema)
