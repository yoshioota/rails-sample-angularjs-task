window.App.controller 'TasksCtrl', [
  '$scope',
  'Tasks',
  ($scope, Tasks) ->

    Tasks.get per_page: 50, (result) ->
      $scope.result = result

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
#          $scope.tasks.unshift(u)
          $scope.taskForm.id = ''
          $scope.taskForm.title = ''
          $scope.taskForm.titleError = ''
          Tasks.get (result)->
            $scope.result = result

        , (u, putResponseHeaders)->
          console.log('save failure')
          $scope.taskForm.titleError = 'error!'

    $scope.Create = ->
      @

    $scope.reload = ->
      console.log('reload')
      Tasks.get {},
        (result) ->
          $scope.result = result

    $scope.Edit = (task) ->
      console.log('edit' + task.id)
      task.isEditing = ! task.isEditing

    $scope.EditCancel = (task) ->
      task.isEditing = false

    $scope.Delete = (id) ->
      Tasks.delete \
        {id: id},
        () ->
          console.log('deleted!')
          Tasks.get (result) ->
            $scope.result = result

    $scope.editTaskKeyDown = (_task, $event) ->
      if $event.which != 13
        return

      tt = new Tasks(id: _task.id)
      tt.title = _task.title
      tt.$update \
        (task, putResponseHeaders) =>
          _task.isEditing = false

    $scope.changePageNo = (pageNo) ->
      Tasks.get {page: pageNo, per_page: 50},
        (result) ->
          $scope.result = result
]
