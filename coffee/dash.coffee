app.controller "DashCtrl", ["$scope", "$http", '$stateParams', '$state', ($scope, $http, $stateParams, $state)->
	# $scope.users = [];
	# $scope.newUser = {};
	# $scope.user = {};
	# # $scope.reputation = 0


	# $scope.getUsers = ->
	# 	$http.get("http://localhost:3000/users.json").success (data) ->
	# 		$scope.users = data
	# 		# console.log(data)

	# # $scope.makeNewUser = ->
	# # 	$http.get("http://localhost:3000/users/new.json").success (data) ->
	# # 		console.log data
	# # 		$scope.newUser = data
		
	# $scope.createUser = ->
	# 	console.log({user: $scope.newUser})
	# 	$http.post("http://localhost:3000/users.json", {user: $scope.newUser}).success((data) ->
	# 		console.log data
	# 		$scope.users.push data
	# 		$scope.newUser = {}
	# 		$state.go('signin')


	# 	).error (errs) ->
 #  			$scope.errors = errs["errors"]
 #  			console.log $scope.errors

	# $scope.showUser = ->
	# 	# console.log $stateParams
	# 	$http.get("http://localhost:3000/users/#{$stateParams.id}.json").success (data) ->
	# 		$scope.user = data
	# 		# console.log data

	# $scope.editUser = (user) ->
	# 	# console.log (user.id)
	# 	$http.put("http://localhost:3000/users/#{user.id}.json", user).success (data) ->
 #  			console.log(data)
  			
	# $scope.showUser()
	# $scope.getUsers()

]