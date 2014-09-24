SessionController = angular.module("SessionController", [])

class SessionsCtrl

	constructor: (@scope, @http, @resource, @rootScope, @location, $state)->

	addSession: (loginUser)->
		console.log(loginUser)
		@http.post("/login.json", {user: loginUser})
		.success (user)=>
			@rootScope.current_user = user
			$state.go('circles-index')
		.error ()=>
			alert("OOPS!")
		


SessionController.controller("SessionsCtrl", ["$scope", "$http", "$resource", "$rootScope", "$location",'$state', SessionsCtrl])