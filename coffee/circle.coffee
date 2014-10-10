app.controller "CirclesCtrl", ["$scope", "$http", "$stateParams", '$state', '$rootScope', 'Circle', ($scope, $http, $stateParams, $state, $rootScope, Circle)->
	$scope.circles = []
	$scope.circle = {}
	# $scope.joinShow = true

	$scope.getCircles = ->
		Circle.all().success (data) ->
			$scope.circles = data
			# console.log "Circle Index", data

	$scope.createCircle = ->
		console.log "hello"
		console.log({room: $scope.circle})
		conf = confirm "Are you sure?"
		if conf
			$http.post("http://localhost:3000/user/#{$rootScope.current_user.id}/rooms.json", {room: $scope.circle}).success((data) ->
				$scope.circles.push data
				$state.go('circle-page', {user_id:$stateParams.user_id, circle_id: data.id})
			).error (errs) ->
				$scope.errors = errs["errors"]
				console.log $scope.errors

	$scope.showCircle = ->
		Circle.show($stateParams.circle_id).success (data) ->
			$scope.circle = data
			# console.log "Show Circle", data

	$scope.circleInfo = ->
		Circle.info($stateParams.circle_id).success (data) ->
			console.log "Circle Info", data
			$scope.circleInfo = data
			for item in data['users']
				if $rootScope.current_user.id == item.id
					$scope.joinShow = false

	$scope.joinCircle = () ->
		# console.log "Before post", data
		$http.post("http://localhost:3000/rooms/#{$stateParams.circle_id}/users/#{$rootScope.current_user.id}.json").success (joinData) ->
			console.log "After post"

	$scope.userGo = ->
  		console.log "Hello"
  		$state.go('user-index')

	$scope.getCircles()
	$scope.showCircle()
	$scope.circleInfo()
]


