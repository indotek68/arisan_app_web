app = angular.module("starter", ["ionic", 'auth0', 'UserFactories', 'CircleFactories']).run(($ionicPlatform) ->
  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins.Keyboard
    StatusBar.styleDefault()  if window.StatusBar
).config(($stateProvider, $urlRouterProvider, $httpProvider, authProvider) ->

  $stateProvider.state( "main", {
  	url: "/",
  	templateUrl: "templates/main.html",
  	controller: "UsersCtrl"
  })
  .state( "dash", {
    url: "/user/:user_id/dash",
    name: 'dash',
    templateUrl: "templates/dash-index.html",
    controller: "DashCtrl"
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
  .state("users-index",{
    url: "/user-index",
    templateUrl: "templates/users-index.html",
    controller: "UsersCtrl"
  })
  .state("user-page",{
    url: "/user/:user_id",
    templateUrl: "templates/user-page.html",
    controller: "UsersCtrl"
  })
  .state("user-edit",{
  	url: "/user/:user_id/edit",
  	templateUrl: "templates/user-edit.html",
  	controller: "UsersCtrl"
  })
  .state("circles-index", {
    url: "/user/:user_id/circles",
    templateUrl: "templates/circles-index.html",
    controller: "CirclesCtrl"
  })
  .state('circle-page', {
    url: '/user/:user_id/circle/:circle_id',
    templateUrl: "templates/circle-page.html",
    controller: "CirclesCtrl"
  })
  .state('circle-new', {
    url: '/user/:user_id/circle-new',
    templateUrl: "templates/circle-new.html",
    controller: "CirclesCtrl"
  })
  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise "/"
)