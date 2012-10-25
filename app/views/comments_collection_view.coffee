CollectionView = require 'views/base/collection_view'
CommentView = require 'views/comment_view'

module.exports = class CommentsCollectionsView extends CollectionView
  className: 'comments'
  tagName: 'ul'
  itemView: CommentView
  container: '#page-container'

  #overwrite CollectionView's default insertion handling to allow nesting
  insertView: (item, view, index, enableAnimation) ->
    super unless item.get 'parent'
