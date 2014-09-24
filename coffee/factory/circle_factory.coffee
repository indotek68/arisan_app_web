CircleFactories = angular.module("CircleFactories", [])

CircleFactories.factory('Circle', ['$http', ($http)->
	return {
		all: ->
			$http.get("http://localhost:3000/rooms.json").success (data)->
				console.log (data)

		post: (newCircle)->
			$http.post("http://localhost:3000/rooms.json", {room: newCircle})

		show: (id)->
			$http.get("http://localhost:3000/rooms/#{id}.json")

		info: (id)->
			$http.get("http://localhost:3000/rooms/#{id}/users.json")
	}
])
