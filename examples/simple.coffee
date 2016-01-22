Schema = require '../lib/'

class CarList extends Schema

  constructor: () ->
    @addChild 'cars', Car, ($) =>
      (a.href for a in $('li.vehicle a'))

class Car extends Schema
  constructor: (args) ->
    @addProperty 'year', ($) ->
      $('.title span').text()
