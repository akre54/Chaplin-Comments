module.exports = (match) ->
  match '', 'comments'
  match ':id', 'comments#show', constraints: { id: /^\d+$/ }
