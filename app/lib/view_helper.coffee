mediator = require 'mediator'

# Application-specific view helpers
# ---------------------------------

# http://handlebarsjs.com/#helpers

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
