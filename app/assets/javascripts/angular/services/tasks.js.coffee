App.factory 'Tasks', [
  '$resource',
  ($resource) ->
    $resource '/tasks.json'
  ]
