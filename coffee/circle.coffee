app.controller "CirclesCtrl", ["$scope", "$http", "$stateParams", '$state', 'Circle', ($scope, $http, $stateParams, $state, Circle)->
	console.log("Hello")
	$scope.circles = []
	$scope.circle = {}

	$scope.getCircles = ->
		Circle.all().success (data) ->
			$scope.circles = data
			console.log(data)

	# $scope.joinCircle = (data) ->
	# 	$http.post("rooms/#{data.id}/users/#{$stateParams.user_id}").success (joinData) ->
	# 		console.log joinData

	$scope.createCircle = ->
		console.log "hello"
		console.log({room: $scope.circle})
		conf = confirm "Are you sure?"
		if conf
			$http.post("http://localhost:3000/user/#{$stateParams.user_id}/rooms.json", {room: $scope.circle}).success((data) ->
				$scope.circles.push data
				console.log "Data ", data
				# $state.go('circle-page', {user_id:$stateParams.user_id, circle_id: data.id})
			).error (errs) ->
				$scope.errors = errs["errors"]
				console.log $scope.errors

	$scope.showCircle = ->
		# console.log $stateParams
		Circle.show($stateParams.circle_id).success (data) ->
			$scope.circle = data
			# console.log data

	$scope.circleInfo = ->
		# console.log $stateParams
		$http.get("http://localhost:3000/rooms/#{$stateParams.circle_id}/users.json").success (data) ->
			$scope.circleInfo = data
			console.log data

	$scope.getCircles()
	$scope.showCircle()
	$scope.circleInfo()
]


