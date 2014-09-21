app.controller "RoomsCtrl", ["$scope", "$http", ($scope, $http)->
	console.log("Hello")
	$scope.getRooms = ->
		$http.get("http://localhost:3000/rooms.json").success (data) ->
			$scope.room = data
			console.log(data)

	$scope.getRooms()
]