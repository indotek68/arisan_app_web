app.controller "DashCtrl", ["$scope", "$http", '$stateParams', '$state', '$rootScope', ($scope, $http, $stateParams, $state, $rootScope)->
	console.log "STARTING TWO"
	$scope.getCurrentRooms = ->
		$scope.$watch "current_user", ()->
			$http.get("http://localhost:3000/user/#{$scope.current_user.id}/dash.json").success (data)->
				console.log "UserRoom", data
				$scope.current_room = data
			# console.log data[0]["user_room"]
			# $scope.host_id = data.user_room[0].host_id

	$scope.userGo = ->
  		console.log "Hello"
  		$state.go('circle-new')

  	$scope.circleGo = ->
  		console.log "Hello"
  		$state.go('circles-index')

  	$scope.getCurrentRooms()
]