Controller = require 'controllers/base/controller'
Error404View = require 'views/errors/404'

module.exports = class ErrorController extends Controller

  historyURL: window.location.pathname

  404: =>
    @view = new Error404View()
    @view.render()
