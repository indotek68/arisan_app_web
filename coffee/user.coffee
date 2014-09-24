app.controller "UsersCtrl", ["$scope", "$http", '$stateParams', '$state', '$location', '$rootScope', 'User', ($scope, $http, $stateParams, $state, $location, $rootScope, User)->
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
			$http.post("http://localhost:3000/login.json", {user: loginUser})
			# $state.go('signin')
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

  	$scope.userGo = ->
  		console.log "Hello"
  		$state.go('user-index')
  			
	$scope.showUser()
	$scope.getUsers()

]