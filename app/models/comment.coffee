Model = require 'models/base/model'

module.exports = class Comment extends Model

  urlRoot: -> "#{@apiRoot}/comments"

  parse: (response) ->
    if @id then _(response.comments).where {@id} else response