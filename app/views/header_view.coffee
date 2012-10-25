View = require 'views/base/view'
template = require 'views/templates/header'
mediator = require 'mediator'

module.exports = class HeaderView extends View
  template: template
  id: 'header'
  className: 'header opaque'
  container: '#header-container'
  autoRender: true

  initialize: =>
    super
    mediator.subscribe 'show-message', @showMessage
    mediator.subscribe 'hide-message', @hideMessage
    mediator.subscribe 'show-comment-deleted-message', @showDeletedMessage
    @delegate 'click', '.undo-comment-delete', @sendDeleteUndo

  showMessage: (content) =>
    @$('#message').html content
    @$el.removeClass 'opaque'

  hideMessage: =>
    @$el.addClass 'opaque'

  showDeletedMessage: =>
    @showMessage "Comment deleted.  <a class='undo-comment-delete'>Undo</a>"

  sendDeleteUndo: ->
    mediator.publish 'undelete-comment'
