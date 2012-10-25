Collection = require 'models/base/collection'
Comment = require 'models/comment'

module.exports = class CommentsCollection extends Collection
  model: Comment

  url: => "#{@apiRoot}/comment"

