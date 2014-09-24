# SessionController = angular.module("SessionController", [])

# class SessionsCtrl

# 	constructor: ($scope, @http, @resource, @rootScope, @location, $state)->

# 	addSession: (loginUser)->
# 		console.log(loginUser)
# 		@http.post("/login.json", {user: loginUser})
# 		.success (user)=>
# 			@rootScope.current_user = user
# 			@location.path("/")
# 		.error ()=>
# 			alert("OOPS!")
		

# SessionController.controller("SessionsCtrl", ["$scope", "$http", "$resource", "$rootScope", "$location", '$state', SessionsCtrl])

app.controller "SessionsCtrl", ["$scope", "$http", "$rootScope", "$location", '$state', ($scope, $http, $rootScope, $location, $state)->
	$scope.addSession = (loginUser)->
		console.log(loginUser)
		$http.post("http://localhost:3000/login.json", {user: loginUser})
		.success (user)=>
			$rootScope.current_user = user
			$state.go('circles-index')
		.error ()=>
			alert("OOPS!")
]


