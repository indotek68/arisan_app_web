app.controller "MainCtrl", ["$scope", "$http", "$rootScope", ($scope, $http, $rootScope)->

	if !$scope.current_user 
		console.log("Checking for current user")
		$http.get("http://localhost:3000/logged_in_user.json")
		.success (user)=>
			console.log "Welcome, ", user
			$rootScope.current_user = user

]