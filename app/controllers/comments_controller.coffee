Controller = require 'controllers/base/controller'
Comment = require 'models/comment'
CommentsCollection = require 'models/comments_collection'
CommentsCollectionView = require 'views/comments_collection_view'
CommentView = require 'views/comment_view'

module.exports = class CommentsController extends Controller

  historyUrl: ''

  index: ->
    @collection = new CommentsCollection()
    @view = new CommentsCollectionView collection: @collection
    @collection.fetch
      success: =>
        @view.render()

   show: (params) ->
     @model = new Comment id: params.id
     @model.fetch
       success: =>
         @view = new CommentView model: @model, solo: true
         @view.render()

