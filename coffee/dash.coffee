app.controller "DashCtrl", ["$scope", "$http", '$stateParams', '$state', ($scope, $http, $stateParams, $state)->
	
	$scope.userGo = ->
  		console.log "Hello"
  		$state.go('circle-new')

  	$scope.circleGo = ->
  		console.log "Hello"
  		$state.go('circles-index')
]