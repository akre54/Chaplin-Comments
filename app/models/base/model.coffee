mediator = require 'mediator'
Chaplin = require 'chaplin'
config = require 'config'

module.exports = class Model extends Chaplin.Model
  apiRoot: config.api.url
  urlKey: 'id'

  urlPath: ->

  fetch: (options) ->
    @trigger 'loadStart'
    options ?= {}
    options.success = _.wrap (options.success ? ->), (func, args...) =>
      func args...
      @trigger 'load'
    super
