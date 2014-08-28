window.App.controller 'TasksCtrl', [
  '$scope',
  'Tasks',
  ($scope, Tasks) ->

    perPage = 10

    Tasks.get per_page: perPage, (result) ->
      $scope.result = result

    $scope.initForm = ->
      $scope.taskForm.id = ''
      $scope.taskForm.title = ''
      $scope.taskForm.titleError = ''

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

          $scope.initForm()

          Tasks.get per_page: perPage, (result)->
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
      task_id = task.id
      setTimeout \
        (-> $('#task-' + task_id + '-title')[0].select())
        , -1

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
      return if pageNo < 1
      return if pageNo > $scope.result.page_info.num_pages

      Tasks.get {page: pageNo, per_page: perPage},
        (result) ->
          $scope.result = result
]
