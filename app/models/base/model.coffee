mediator = require 'mediator'
Chaplin = require 'chaplin'
config = require 'config'

module.exports = class Model extends Chaplin.Model
  apiRoot: config.api.url
