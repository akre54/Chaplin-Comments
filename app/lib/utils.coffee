Chaplin = require 'chaplin'
mediator = require 'mediator'

# Application-specific utilities
# ------------------------------

# Delegate to Chaplin’s utils module
utils = Chaplin.utils.beget Chaplin.utils

module.exports = utils
