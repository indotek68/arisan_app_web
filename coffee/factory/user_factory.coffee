UserFactories = angular.module("UserFactories", [])

UserFactories.factory('User', ['$http', ($http)->
	return {
		all: ->
			$http.get("http://arisan-api.herokuapp.com/users.json").success (data)->
				console.log (data)
				
		post: (newUser)->
			$http.post("http://arisan-api.herokuapp.com/users.json", {user: newUser})

		show: (id)->
			$http.get("http://arisan-api.herokuapp.com/users/#{id}.json")

		# edit: (user)->
		# 	$http.put("http://arisan-api.herokuapp.com/users/#{user}.json", {user: user})

	}
])