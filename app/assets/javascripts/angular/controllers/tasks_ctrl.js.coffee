window.App.controller 'TasksCtrl', [
  '$scope',
  'Tasks',
  ($scope, Tasks) ->
    $scope.tasks = Tasks.query()

    $scope.addTask = ->
      task = new Tasks()
      task.title = $scope.taskForm.title
      task.$save \
        (u, putResponseHeaders) ->
          if $scope.hasError
            console.log('save error')
          else
            console.log('save no error')
          console.log('save ok')
          $scope.tasks.unshift(u)
          $scope.taskForm.title = ""
          $scope.taskForm.titleError = ''
          @
        , (u, putResponseHeaders)->
          console.log('save failure')
          $scope.taskForm.titleError = 'error!'
          @
      @

    $scope.Create = ->
      @

    $scope.reload = ->
      console.log('reload')
      $scope.tasks = Tasks.query()
      @

    $scope.Edit = (id) ->
      console.log('edit' + id)
      @

    $scope.Delete = (id) ->
      Tasks.delete \
        {id: id},
        () ->
          console.log('deleted!')
          $scope.tasks = Tasks.query()
          @
      @

#      task. {id: id}, ()->
#      console.log('deleted!')

#      task.delete({id: id},
#        ->
#          console.log('deleted!')
#      )
#      console.log('delete' + id)
      true

]
