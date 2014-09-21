var app;

app = angular.module("starter", ["ionic"]).run(function($ionicPlatform) {
  return $ionicPlatform.ready(function() {
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      return StatusBar.styleDefault();
    }
  });
}).config(function($stateProvider, $urlRouterProvider, $httpProvider) {
  $stateProvider.state("main", {
    url: "/",
    templateUrl: "templates/main.html",
    controller: "UsersCtrl"
  }).state("signup", {
    url: "/signup",
    templateUrl: "templates/signup.html",
    controller: "UsersCtrl"
  }).state("signin", {
    url: "/signin",
    templateUrl: "templates/signin.html",
    controller: "UsersCtrl"
  }).state("profile", {
    url: "/user/:id/edit",
    templateUrl: "templates/profile.html",
    controller: "UsersCtrl"
  });
  return $urlRouterProvider.otherwise("/");
});

app.controller("RoomsCtrl", [
  "$scope", "$http", function($scope, $http) {
    console.log("Hello");
    $scope.getRooms = function() {
      return $http.get("http://localhost:3000/rooms.json").success(function(data) {
        $scope.room = data;
        return console.log(data);
      });
    };
    return $scope.getRooms();
  }
]);

app.controller("UsersCtrl", [
  "$scope", "$http", function($scope, $http) {
    $scope.users = [];
    $scope.newUser = {};
    $scope.newToDo = {};
    $scope.getUsers = function() {
      return $http.get("http://localhost:3000/users.json").success(function(data) {
        return $scope.users = data;
      });
    };
    $scope.createUser = function() {
      return $http.post("http://localhost:3000/users.json", $scope.newUser).success(function(data) {
        console.log(data);
        $scope.users.push(data);
        return $scope.newUser = {};
      }).error(function(errs) {
        $scope.errors = errs["errors"];
        return console.log($scope.errors);
      });
    };
    return $scope.getUsers();
  }
]);


