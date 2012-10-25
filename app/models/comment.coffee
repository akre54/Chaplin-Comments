Model = require 'models/base/model'

module.exports = class Comment extends Model

  url: => if @id then "#{@apiRoot}/comment/#{@id}" else "#{@apiRoot}/comment"

