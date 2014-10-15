app.controller "SessionsCtrl", ["$scope", "$http", "$rootScope", "$location", '$state', ($scope, $http, $rootScope, $location, $state)->
	$scope.addSession = (loginUser)->
		$http.post("http://arisan-api.herokuapp.com/login.json", {user: loginUser})
		.success( (user)=>
			# console.log "Helllllo", user
			$rootScope.current_user = user
			$state.go('dash')
		).error (errors)=>
			# console.log errors
			alert "Invalid email or password"
]


