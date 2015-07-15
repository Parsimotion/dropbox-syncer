_ = require("lodash")
XLS = require("xlsjs")

module.exports =

class Excel2003OrdersParser
  getOrders: (data) ->
    try
      workbook = XLS.read data, type: "binary"
    catch e
      throw new Error("Error reading the excel")

    @_getDataFrom(workbook).map (row) =>
      _.mapValues row, (value) =>
        if value is "TRUE" then true
        else if value is "FALSE" then false
        else value

  _getDataFrom: (workbook) ->
    XLS.utils.sheet_to_json (@_getFirstSheet workbook)

  _getFirstSheet: (workbook) ->
    workbook.Sheets[workbook.SheetNames[0]]
