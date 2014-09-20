app.controller "RoomCtrl", ["$scope", "$http", ($scope, $http)->
	console.log($scope)
	$scope.getRooms = ->
		$http.get("http://localhost:3000/rooms.json").success (data) ->
			$scope.todos = data
			console.log(data)

	$scope.getRooms()

]