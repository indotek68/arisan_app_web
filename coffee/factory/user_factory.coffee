UserFactories = angular.module("UserFactories", [])

UserFactories.factory('User', ['$http', ($http)->
	return {
		all: ->
			$http.get("http://localhost:3000/users.json").success (data)->
				console.log (data)
				
		post: (newUser)->
			$http.post("http://localhost:3000/users.json", {user: newUser})

		show: (id)->
			$http.get("http://localhost:3000/users/#{id}.json")

		# edit: (user)->
		# 	$http.put("http://localhost:3000/users/#{user}.json", {user: user})

	}
])