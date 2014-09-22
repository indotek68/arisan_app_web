app.controller "CirclesCtrl", ["$scope", "$http", ($scope, $http)->
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


	$scope.getCircles()
]