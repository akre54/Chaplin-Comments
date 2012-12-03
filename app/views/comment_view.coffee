View = require 'views/base/view'
template = require 'views/templates/comment'
Comment = require 'models/comment'
mediator = require 'mediator'

module.exports = class CommentView extends View
  template: template
  className: "comment"
  id: => "comment-#{@model.id}"
  tagName: "li"

  # pass `solo = true` to options if showing only a single comment
  initialize: (options) =>
    parent = @model.get 'parent'
    @container =
      if parent? and !options.solo
        "#comment-#{parent} > .children"
      else
        ".comments"
    super

  afterRender: ->
    super
    @delegateEvents()
    setInterval @updateTimestamp, (Math.floor(Math.random() * 35) + 5) * 1000

  delegateEvents: ->
    @undelegate()
    @delegate 'click', "> .content .delete-post", @deletePost
    @delegate 'click', "> .content .reply-link", @openReply
    @delegate 'click', "> .content button", @submitReply

  updateTimestamp: =>
    return if @disposed
    newTimeAgo = Handlebars.helpers.time_ago @model.get 'created_at'
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
      author: # imagine this were on a app-wide user model
        name: 'Michael Jordan'
        id: 23
        profile_img_url: 'http://i.imgur.com/1NKhJb.jpg'
        qualification: 'Abassador to Space'
      content: $(evt.target).prev().val()
      parent: @model.id
      created_at: (new Date()).getTime()
    newPost.save()
    @model.collection.add newPost
    @closeReply()

