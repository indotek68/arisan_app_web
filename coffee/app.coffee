app = angular.module("starter", ["ionic"]).run(($ionicPlatform) ->
  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins.Keyboard
    StatusBar.styleDefault()  if window.StatusBar
).config(($stateProvider, $urlRouterProvider, $httpProvider) ->

  $stateProvider.state( "main", {
  	url: "/",
  	templateUrl: "templates/main.html",
  	controller: "UsersCtrl"
  })
  .state("signup",{
  	url: "/signup",
  	templateUrl: "templates/signup.html",
  	controller: "UsersCtrl"
  })
  .state("signin",{
  	url: "/signin",
  	templateUrl: "templates/signin.html",
  	controller: "UsersCtrl"
  })
  .state("profile-page",{
    url: "/users/:id",
    templateUrl: "templates/profile-page.html",
    controller: "UsersCtrl"
  })
  .state("profile-edit",{
  	url: "/users/:id/edit",
  	templateUrl: "templates/profile-edit.html",
  	controller: "UsersCtrl"
  })
  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise "/"
)