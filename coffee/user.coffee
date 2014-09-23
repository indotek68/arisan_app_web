app.controller "UsersCtrl", ["$scope", "$http", '$stateParams', '$state', '$location', 'User', ($scope, $http, $stateParams, $state, $location, User)->
	$scope.users = [];
	$scope.newUser = {};
	$scope.user = {};
	# $scope.reputation = 0

	$scope.getUsers = ->
		User.all().success (data) ->
			$scope.users = data
		
	$scope.createUser = ->
		# console.log({user: $scope.newUser})
		User.post($scope.newUser).success((data) ->
			console.log data
			$scope.users.push data
			$scope.newUser = {}
			$state.go('signin')
		).error (errs) ->
  			$scope.errors = errs["errors"]
  			console.log $scope.errors

	$scope.showUser = ->
		# console.log $stateParams
		User.show($stateParams.user_id).success (data) ->
			$scope.user = data

	$scope.editUser = (user) ->
		User.edit(user).success (data) ->
  			console.log(data)
  			$state.go('user-page', {user_id: user.id});
  			
	$scope.showUser()
	$scope.getUsers()

]