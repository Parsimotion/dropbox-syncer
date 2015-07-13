_ = require("lodash")
_.mixin require("lodash-deep")

###
This is a transformer between the model and the DTO that the settings will use
###
class Transformer
  constructor: (@mappings) ->

  toDto: (model) ->
    dto = {}

    setValue = _.partial @_updateProperty, dto, model
    @mappings.forEach ({from, to}) -> setValue to, from

    dto

  updateModel: (model, dto) ->
    setValue = _.partial @_updateProperty, model, dto
    @mappings.forEach ({from, to}) -> setValue from, to, true

  _updateProperty: (destination, source, destinationPropertyPath, sourcePropertyPath, ignoreNullAndUndefined = false) ->
    newValue = _.deepGet source, sourcePropertyPath

    if ignoreNullAndUndefined && !newValue?
      return

    if _.isFunction destination.set
      destination.set destinationPropertyPath, newValue
    else
      _.deepSet destination, destinationPropertyPath, newValue

module.exports = new Transformer [
  from: "settings.saved", to: "saved"
,
<<<<<<< HEAD
  from: "syncer.settings.parser", to: "parser.name"
,
  from: "syncer.settings.fileName", to: "fileName"
,
  from: "syncer.settings.columns", to: "columns"
,
  from: "tokens.producteca", to: "productecaToken"
,
  from: "settings.priceList", to: "priceList"
,
  from: "settings.warehouse", to: "warehouse"
,
  from: "settings.synchro", to: "synchro"
,
  from: "settings.identifier", to: "identifier"
=======
  from: "example.property", to: "exampleProperty"
,
  from: "another.property", to: "another"
>>>>>>> c6fd6501923fe3458eb4d26c2f43af59c6ca090b
]
