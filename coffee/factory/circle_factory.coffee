CircleFactories = angular.module("CircleFactories", [])

CircleFactories.factory('Circle', ['$http', ($http)->
	return {
		all: ->
			$http.get("http://arisan-api.herokuapp.com/rooms.json").success (data)->
				console.log (data)

		# post: (newCircle)->
		# 	$http.post("http://arisan-api.herokuapp.com/rooms.json", {room: newCircle})

		show: (id)->
			$http.get("http://arisan-api.herokuapp.com/rooms/#{id}.json")

		info: (id)->
			$http.get("http://arisan-api.herokuapp.com/rooms/#{id}/users.json")
	}
])
