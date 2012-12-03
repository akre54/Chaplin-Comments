Controller = require 'controllers/base/controller'
Comment = require 'models/comment'
CommentsCollection = require 'models/comments_collection'
CommentsCollectionView = require 'views/comments_collection_view'
CommentView = require 'views/comment_view'

module.exports = class CommentsController extends Controller

  historyUrl: ''

  index: ->
    @collection = new CommentsCollection()
    @view = new CommentsCollectionView {@collection}
    @collection.fetch()

  show: (params) ->
    params.id = parseInt params.id, 10
    @model = new Comment id: params.id
    @view = new CommentView {@model, solo: true}
    @model.fetch()
