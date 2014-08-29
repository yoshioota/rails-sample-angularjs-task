window.App.controller 'TasksCtrl', [
  '$scope',
  'Tasks',
  ($scope, Tasks) ->

    currentPageNo = 1
    perPage       = 10

    $scope.initForm = ->
      $scope.taskForm.id = ''
      $scope.taskForm.title = ''
      $scope.taskForm.titleError = ''

    $scope.addTask = ->
      task = new Tasks(title: $scope.taskForm.title)
      task.$save \
        (u, putResponseHeaders) ->
          if $scope.hasError
            console.log('save error')
          else
            console.log('save no error')
          console.log('save ok')

          $scope.initForm()
          $scope.search()

        , (u, putResponseHeaders)->
          console.log('save failure')
          $scope.taskForm.titleError = 'error!'

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
          $scope.search()

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
      currentPageNo = pageNo
      $scope.search()

    $scope.search = () ->
      Tasks.get {page: currentPageNo, per_page: perPage},
        (result) ->
          $scope.result = result

    # init
    $scope.search()
]
