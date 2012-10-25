mediator = require 'mediator'
utils = require 'chaplin/lib/utils'

# Application-specific view helpers
# ---------------------------------

# http://handlebarsjs.com/#helpers

# Conditional evaluation
# ----------------------

# Choose block by user login status
Handlebars.registerHelper 'if_logged_in', (options) ->
  if mediator.user
    options.fn(this)
  else
    options.inverse(this)

# Map helpers
# -----------

# Make 'with' behave a little more mustachey
Handlebars.registerHelper 'with', (context, options) ->
  if not context or Handlebars.Utils.isEmpty context
    options.inverse(this)
  else
    options.fn(context)

# Inverse for 'with'
Handlebars.registerHelper 'without', (context, options) ->
  inverse = options.inverse
  options.inverse = options.fn
  options.fn = inverse
  Handlebars.helpers.with.call(this, context, options)

# Evaluate block with context being current user
Handlebars.registerHelper 'with_user', (options) ->
  context = mediator.user or {}
  Handlebars.helpers.with.call(this, context, options)

Handlebars.registerHelper 'time_ago', (timestamp) ->
  plural = Handlebars.helpers.plural
  currentTime = (new Date()).getTime() / 1000 # in seconds
  elapsed = currentTime - timestamp
  if elapsed < 10
    "just now"
  else if elapsed < 60
    "#{Math.floor elapsed} #{plural Math.floor(elapsed), 'second'} ago"
  else if (elapsed /= 60) < 60
    "#{Math.floor elapsed} #{plural Math.floor(elapsed), 'minute'} ago"
  else if (elapsed /= 60) < 24
    "#{Math.floor elapsed} #{plural Math.floor(elapsed), 'hour'} ago"
  else if (elapsed /= 24) < 365
    "#{Math.floor elapsed} #{plural Math.floor(elapsed), 'day'} ago"
  else
    "#{Math.floor elapsed} #{plural Math.floor(elapsed), 'year'} ago"

Handlebars.registerHelper 'pretty_date', (timestamp) ->
  date = new Date timestamp * 1000
  date

Handlebars.registerHelper 'plural', (count, singular, plural) ->
  plural or= "#{singular}s"
  if count is 1
    singular
  else
    plural
