ZetaLibraParser = require("./zetaLibraParser")
_ = require("lodash")

describe "ZetaLibra Parser", ->
  parser = null

  beforeEach ->
    parser = new ZetaLibraParser()

  it "mergea los stocks con los de precios y suma los lotes", ->
    data =
      stocks: [
        { CodigoArticulo: "RVERDES", CodigoLote: "AL", Stock: "5.00000" }
        { CodigoArticulo: "UYR", CodigoLote: {}, Stock: "299998140.00000" }
        { CodigoArticulo: "RVERDES", CodigoLote: "AL", Stock: "3.00000" }
      ]
      prices: [
        { CodigoArticulo: "UYR", PrecioConIVA: "0.25925"}
        { CodigoArticulo: "RVERDES", PrecioConIVA: "900.00000"}
      ]

    ajustes = _.map parser.getAjustes(data), _.partialRight(_.pick, ['identifier', 'name', 'price', 'stock'])

    ajustes.should.eql [
      { identifier: "RVERDES", price: 900, stock: 8 }
      { identifier: "UYR", price: 0.25925, stock: 299998140 }
    ]
