app.controller "UsersCtrl", ["$scope", "$http", '$stateParams', ($scope, $http, $stateParams)->
	$scope.users = [];
	$scope.newUser = {};
	# $scope.user = {};
	# $scope.reputation = 0


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

	$scope.showUser = ->
		# console.log $stateParams
		$http.get("http://localhost:3000/users/#{$stateParams.id}.json").success (data) ->
			$scope.user = data
			# console.log data

	$scope.editUser = (user) ->
		# console.log (user.id)
		$http.put("http://localhost:3000/users/#{user.id}.json", user).success (data) ->
  			console.log(data)
  			
	$scope.showUser()
	$scope.getUsers()

]