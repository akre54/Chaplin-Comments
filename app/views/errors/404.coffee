PageView = require 'views/base/page_view'
template = require 'views/templates/errors/404'

module.exports = class Error404View extends PageView
  template: template
