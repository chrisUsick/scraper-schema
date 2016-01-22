Crawler = require 'crawler'
class Schema
  properties = {}
  children = {}
  addProperty: (name, selector) ->
    properties[name] = selector

  addChild: (name, schema, selector) ->
    children[name] =
      schema: new schema()
      selector: selector

  scrape: () ->
    @crawler = new Cralwer
      maxConnection: 10

    @crawler.queue
      uri: @root
      callback: (err, res, $) =>
        throw err if err
        @extractData $


  extractData: ($) ->
    obj = {}
    for prop, selector of properties
      obj[prop] = selector $

    for prop, child of children
      obj[prop] = yield child.schema.scrape(child.selector($))

    data.push obj
