Crawler = require 'crawler'
P = require 'bluebird'
module.exports = class Schema
  properties = {}
  children = {}
  data = []
  constructor: () ->
    @crawler = new Crawler
      maxConnection: 10
      onDrain: ->
        console.log 'all done'
  addProperty: (name, selector) ->
    properties[name] = selector

  addChild: (name, schema, selector) ->
    children[name] =
      schema: new schema()
      selector: selector

  # scrape: (uris) ->
  #   uris =  uris || @root
  #   if (uris instanceof Array)
  #     promise = P.all (@scrapePage uri for uri in uris)
  #   else
  #     promise = @scrapePage uris

  #   promise
  scrapePage: (uri)->
      new P (resolve, reject) =>
        @crawler.queue
          uri: uri
          callback: P.coroutine((err, res, $) =>
            reject err if err
            yield @extractData($)
            resolve data
          )

  extractData: ($) ->
    obj = {}
    for prop, selector of properties
      obj[prop] = selector $
    promises = []
    for prop, child of children
      promise = child.schema.scrapePage(child.selector($))
        .then (scraped) =>
          obj[prop] ||= []
          obj[prop].push = scraped
      promises.push promise
    P.all(promises)
      .then =>
          data.push obj
