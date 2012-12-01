View = require 'views/base/view'
template = require 'views/templates/comment'
Comment = require 'models/comment'
mediator = require 'mediator'

module.exports = class CommentView extends View
  template: template
  className: "comment"
  id: => "comment-#{@model.id}"
  tagName: "li"

  initialize: (options) =>
    super

    parent = @model.get 'parent'
    @container = if parent? and !options.solo then "#comment-#{parent} > .children" else "#page-container"

    @delegate 'click', "##{@id()} > .content .delete-post", @deletePost
    @delegate 'click', "##{@id()} > .content .reply-link", @openReply
    @delegate 'click', "##{@id()} > .content button", @submitReply

    setInterval @updateTimestamp, (Math.floor(Math.random() * 35) + 5) * 1000

  updateTimestamp: =>
    return if @disposed
    newTimeAgo = Handlebars.helpers.time_ago @model.get 'create_time'
    @$("> .content .timestamp").text newTimeAgo

  deletePost: =>
    @$el.fadeOut()
    mediator.publish 'show-comment-deleted-message'
    mediator.subscribe 'undelete-comment', ->
      processDelete true
      clearTimeout delayedDelete

    processDelete = (undelete) =>
      mediator.unsubscribe 'undelete-comment'
      mediator.publish 'hide-message'
      unless undelete
        @model.destroy()
      else
        @$el.show()

    delayedDelete = setTimeout processDelete, 4000
  
  openReply: ->
    @$("> .content .reply-form").removeClass('hidden')

  closeReply: ->
    @$("> .content .reply-form").addClass('hidden')

  submitReply: (evt) =>
    evt.preventDefault()
    evt.stopPropagation()

    newPost = new Comment
      id: _.uniqueId(300)
      author:
        id: 23
        profile_img_url: 'http://i.imgur.com/1NKhJb.jpg'
        qualification: 'Abassador to Space'
      content: $(evt.target).prev().val()
      parent: @model.id
      create_time: (new Date()).getTime()
    newPost.save()
    @model.collection.add newPost
    @closeReply()

