Chaplin = require 'chaplin'
Model = require 'models/base/model'
config = require 'config'

module.exports = class Collection extends Chaplin.Collection
  apiRoot: config.api.url
  model: Model

  initialize: (models, options) ->
    @url = options.url if options?.url?
    super

