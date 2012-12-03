config = {api: {}}

production = yes

config.api.url =
  if production
    'http://ss-comments-api.herokuapp.com'
  else
    'http://localhost:3000'

module.exports = config
