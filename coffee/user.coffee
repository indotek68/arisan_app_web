app.controller "UsersCtrl", ["$scope", "$http", ($scope, $http)->
	$scope.users = [];
	$scope.newUser = {};
	$scope.newToDo = {}

	$scope.getUsers = ->
		$http.get("http://localhost:3000/users.json").success (data) ->
			$scope.users = data
			# console.log(data)


	$scope.createUser = ->
		# console.log($http)
		$http.post("http://localhost:3000/users.json", $scope.newUser).success((data) ->
			console.log data
			$scope.users.push data
			$scope.newUser = {}
		).error (errs) ->
  			$scope.errors = errs["errors"]
  			console.log $scope.errors


	$scope.getUsers()
]