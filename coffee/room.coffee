app.controller "CirclesCtrl", ["$scope", "$http", ($scope, $http)->
	console.log("Hello")
	$scope.getCircles = ->
		$http.get("http://localhost:3000/rooms.json").success (data) ->
			$scope.circles = data
			console.log(data)

	$scope.getCircles()
]