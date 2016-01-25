Schema = require '../lib/index.js'
nvcr = require 'nock-vcr'
nvcr.insertCassette 'fixtures'
class CarList extends Schema

  constructor: () ->
    super
    @root = 'http://www.jandjautosales.ca/used-inventory/index.htm'
    @addChild 'cars', Car, ($) =>
      # (a.href for a in $('li.vehicle a'))
      $('li.vehicle a')[67].href

class Car extends Schema
  constructor: (args) ->
    super
    @root = 'http://www.jandjautosales.ca/used/Audi/2010-Audi-A3-4b22ed8e0a0e08bd23da9bd697bded5a.htm'
    @addProperty 'year', ($) ->
      console.log 'finding year from car'
      $('.title > h1 span').text()


carList = new CarList()
carList.scrapePage(carList.root)
  .then (data) ->
    console.log data
#
# car = new Car()
# car.scrape()
#   .then (data) ->
#     nvcr.ejectCassette()
#     console.log data
