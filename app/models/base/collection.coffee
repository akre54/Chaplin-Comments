Chaplin = require 'chaplin'
Model = require 'models/base/model'
config = require 'config'

module.exports = class Collection extends Chaplin.Collection
  apiRoot: config.api.url
  model: Model
