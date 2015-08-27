FixedLengthParser = require("./fixedLengthParser")
_ = require("lodash")

describe "Fixed length parser", ->
  parser = null

  beforeEach ->
    parser = new FixedLengthParser()

  it "puede obtener una ajuste a partir de un string de ancho fijo", ->
    data = """
924065117102                  ALR 111 50W 12V 24G                                        124.49     14.00
"""

    ajuste = _.pick parser.getAjustes(data)[0], ['identifier', 'name', 'price', 'stock']

    ajuste.should.eql
      identifier: "924065117102"
      name: "ALR 111 50W 12V 24G"
      price: 124.49
      stock: 14

    ajuste.price.should.be.a.Number
    ajuste.stock.should.be.a.Number

  it "omite lineas vacias", ->
    data = """
924065117102                  ALR 111 50W 12V 24G                                        124.49     14.00


"""

    parser.getAjustes(data)[0].identifier.should.equal "924065117102"

  it "funciona con el newline de Windows", ->
    data = "924065117102                  ALR 111 50W 12V 24G                                        124.49     14.00\r\n"
    parser.getAjustes(data)[0].identifier.should.equal "924065117102"
