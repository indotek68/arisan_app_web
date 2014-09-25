app.controller "CirclesCtrl", ["$scope", "$http", "$stateParams", '$state', '$rootScope', 'Circle', ($scope, $http, $stateParams, $state, $rootScope, Circle)->
	console.log("Hello")
	$scope.circles = []
	$scope.circle = {}
	$scope.joinShow = true

	$scope.getCircles = ->
		Circle.all().success (data) ->
			$scope.circles = data
			console.log "Circle Index", data

	# $scope.joinCircle = (data) ->
	# 	$http.post("rooms/#{data.id}/users/#{$stateParams.user_id}").success (joinData) ->
	# 		console.log joinData

	$scope.createCircle = ->
		console.log "hello"
		console.log({room: $scope.circle})
		conf = confirm "Are you sure?"
		if conf
			$http.post("http://localhost:3000/user/#{$rootScope.current_user.id}/rooms.json", {room: $scope.circle}).success((data) ->
			# $http.post("http://localhost:3000/rooms.json", {room: $scope.circle}).success((data) ->
				$scope.circles.push data
				console.log "Data ", data
				$state.go('circle-page', {user_id:$stateParams.user_id, circle_id: data.id})
			).error (errs) ->
				$scope.errors = errs["errors"]
				console.log $scope.errors

	$scope.showCircle = ->
		# console.log $stateParams
		Circle.show($stateParams.circle_id).success (data) ->
			$scope.circle = data
			# console.log "Show Circle", data

	$scope.circleInfo = ->
		# console.log $stateParams#{$stateParams.circle_id}
		Circle.info($stateParams.circle_id).success (data) ->
			$scope.circleInfo = data
			console.log "Circle Info", data
			for item in data
				if $rootScope.current_user.id == item.id
					$scope.joinShow = false
			

	$scope.userGo = ->
  		console.log "Hello"
  		$state.go('user-index')

	$scope.getCircles()
	$scope.showCircle()
	$scope.circleInfo()
]


