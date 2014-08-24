window.App.factory 'Tasks',
  [
    '$resource',
    ($resource) ->
      $resource '/tasks/:id.json', {id: '@id'},
        {
          'update': { method: 'PUT' }
        }
  ]
