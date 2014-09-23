app.controller "CirclesCtrl", ["$scope", "$http", "$stateParams", ($scope, $http, $stateParams)->
	console.log("Hello")
	$scope.circles = []
	$scope.circle = {}

	$scope.getCircles = ->
		$http.get("http://localhost:3000/rooms.json").success (data) ->
			$scope.circles = data
			console.log(data)

	$scope.createCircle = ->
		console.log({room: $scope.circle})
		conf = confirm "Are you sure?"
		if conf
			$http.post("http://localhost:3000/rooms.json", {room: $scope.circle}).success((data) ->
				$scope.circles.push data
				console.log data
			).error (errs) ->
				$scope.errors = errs["errors"]
				console.log $scope.errors

	$scope.showCircle = ->
		# console.log $stateParams
		$http.get("http://localhost:3000/rooms/#{$stateParams.id}.json").success (data) ->
			$scope.circle = data
			# console.log data

	$scope.circleInfo = ->
		# console.log $stateParams
		$http.get("http://localhost:3000/rooms/#{$stateParams.id}/users.json").success (data) ->
			$scope.circleInfo = data
			console.log data


	$scope.getCircles()
	$scope.showCircle()
	$scope.circleInfo()
]


