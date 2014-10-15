app.controller "MainCtrl", ["$scope", "$http", "$rootScope",'$ionicModal', ($scope, $http, $rootScope, $ionicModal)->
	console.log "STARTIN"
	if !$scope.current_user 
		console.log("Checking for current user")
		$http.get("http://arisan-api.herokuapp.com/logged_in_user.json")
		.success (user)=>
			console.log "Welcome, ", user
			$rootScope.current_user = user

	# $scope.showButton = (user_id) ->
	# 	if $scope.current_user.id == user_id
	# 		return true

	$ionicModal.fromTemplateUrl('templates/modal.html', { scope: $scope, animation: 'slide-in-up'}).then (modal)->

		$scope.modal = modal;

		$scope.closeModal = () ->
			console.log "Hello Hello"
			console.log $scope.modal
			$scope.modal.hide()

		$scope.hello = () ->
			alert "Hello"

		$scope.openModal = () ->
			console.log $scope.modal
			$scope.modal.show()

		$scope.$on('$destroy', ()->
			$scope.modal.remove()
		)

		$scope.$on('modal.hidden', ()->
		)

		$scope.$on(modal.removed, ()->
		)
		
	# $scope.showButton()
]