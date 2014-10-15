
app.controller "UsersCtrl", ["$scope", "$http", '$stateParams', '$state', '$location', '$rootScope', 'User', ($scope, $http, $stateParams, $state, $location, $rootScope, User)->
	console.log("Initialized UsersCtrl")
	console.log ($rootScope)
	$scope.users = [];
	$scope.newUser = {};
	$scope.user = {};
	$scope.current_user = $rootScope.current_user
	# $scope.reputation = 0
	# $scope.show = true

	$scope.getUsers = ->
		User.all().success (data) ->
			$scope.users = data
		
	$scope.createUser = ->
		console.log("Running!")
		console.log( $scope.newUser)
		User.post($scope.newUser).success((data) ->
			console.log data
			$scope.users.push data
			$scope.newUser = {}
			$rootScope.current_user = data
			$state.go('user-edit', {user_id: $rootScope.current_user.id})
		).error (errs) ->
  			$scope.errors = errs["errors"]
  			console.log $scope.errors

	$scope.showUser = ->
		# console.log $stateParams
		User.show($stateParams.user_id).success (data) ->
			$scope.user = data
			if ($scope.current_user.id == data.id)
				$scope.show = true

	$scope.editUser = (user) ->
		$http.put("http://arisan-api.herokuapp.com/users/#{$stateParams.user_id}.json", {user: user}).success (data)->
  			console.log(data)
  			$state.go('user-page', {user_id: $stateParams.user_id});
		# console.log user
		# # if $scope.current_user
		# User.edit($stateParams.user_id).success (data) ->
		# $http.put("http://arisan-api.herokuapp.com/users/#{$stateParams.user_id}.json", {user: user}).succes (data)->
		# # User.edit($stateParams.user_id).success (data) ->
  # 			console.log(data)
  # 			$state.go('user-page', {user_id: $stateParams.user_id});

  	$scope.userGo = ->
  		console.log "Hello"
  		$state.go('user-index')
  			
	$scope.showUser()
	$scope.getUsers()

]