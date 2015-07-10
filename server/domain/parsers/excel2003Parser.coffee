_ = require("lodash")
XLS = require("xlsjs")
Adjustment = require("producteca-sdk").Sync.Adjustment

module.exports =

class Excel2003Parser
  constructor: (settings) ->
    @columnsMapping = settings?.columns

  getAjustes: (data) ->
    workbook = XLS.read data, type: "binary"
    _.map (@_getDataFrom workbook), (row) => new Adjustment (@_toDto row)

  _getDataFrom: (workbook) ->
    XLS.utils.sheet_to_json (@_getFirstSheet workbook)

  _getFirstSheet: (workbook) ->
    workbook.Sheets[workbook.SheetNames[0]]

  _toDto: (row) =>
    columns = ["sku", "nombre", "precio", "stock"]
    values = _.map columns, (col) => row[@columnsMapping[col]]

    _.zipObject ["identifier", "name", "price", "stock"], values
