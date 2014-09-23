app = angular.module("starter", ["ionic", 'auth0']).run(($ionicPlatform) ->
  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins.Keyboard
    StatusBar.styleDefault()  if window.StatusBar
).config(($stateProvider, $urlRouterProvider, $httpProvider, authProvider) ->

  $stateProvider.state( "main", {
  	url: "/",
  	templateUrl: "templates/main.html",
  	controller: "UsersCtrl"
  })
  $stateProvider.state( "dash", {
    url: "/dash",
    templateUrl: "templates/dash-index.html",
    controller: "DashCtrl"
  })
  $stateProvider.state( "dash-host", {
    url: "/dash/host",
    templateUrl: "templates/dash-host.html",
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
    url: "/users",
    templateUrl: "templates/users-index.html",
    controller: "UsersCtrl"
  })
  .state("user-page",{
    url: "/users/:id",
    templateUrl: "templates/user-page.html",
    controller: "UsersCtrl"
  })
  .state("user-edit",{
  	url: "/users/:id/edit",
  	templateUrl: "templates/user-edit.html",
  	controller: "UsersCtrl"
  })
  .state("circles-index", {
    url: "/circles",
    templateUrl: "templates/circles-index.html",
    controller: "CirclesCtrl"
  })
  .state('circle-page', {
    url: '/circle/:id',
    templateUrl: "templates/circle-page.html",
    controller: "CirclesCtrl"
  })
  .state('circle-new', {
    url: '/circle-new',
    templateUrl: "templates/circle-new.html",
    controller: "CirclesCtrl"
  })
  # if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise "/"
)