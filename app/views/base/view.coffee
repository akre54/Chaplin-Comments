Chaplin = require 'chaplin'
utils = require 'lib/utils'
require 'lib/view_helper'

module.exports = class View extends Chaplin.View

  getTemplateData: ->
    Model = require 'models/base/model'
    serialize = (object) ->
      result = {}
      for key, value of object
        result[key] = if value instanceof Model
          serialize value.getAttributes()
        else
          value
      result

    modelAttributes = @model and @model.getAttributes()
    templateData = if modelAttributes
      # Return an object which delegates to the returned attributes
      # object so a custom getTemplateData might safely add and alter
      # properties (at least primitive values).
      utils.beget serialize modelAttributes
    else
      {}

    templateData

  getTemplateFunction: ->
    @template
