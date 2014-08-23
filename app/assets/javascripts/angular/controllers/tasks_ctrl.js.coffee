App.controller 'TasksCtrl', [
  '$scope',
  'Tasks',
  ($scope, Tasks) ->
    $scope.tasks = Tasks.query()

    $scope.addTask = ->
#      raisePriorities()
      task = @taskService.create(description: $scope.taskDescription)
      task.priority = 1
      $scope.list.tasks.unshift(task)
      $scope.taskDescription = ""

]
