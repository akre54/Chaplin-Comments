Controller = require 'controllers/base/controller'
HeaderView = require 'views/header_view'

module.exports = class HeadersController extends Controller
  initialize: ->
    @view = new HeaderView()
