Model = require 'models/base/model'

module.exports = class Comment extends Model

  urlRoot: -> "#{@apiRoot}/comments"