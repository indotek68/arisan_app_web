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
    controller: "RoomCtrl"
  });
  return $urlRouterProvider.otherwise("/");
});

app.controller("RoomCtrl", [
  "$scope", "$http", function($scope, $http) {
    console.log($scope);
    $scope.getRooms = function() {
      return $http.get("http://localhost:3000/rooms.json").success(function(data) {
        $scope.todos = data;
        return console.log(data);
      });
    };
    return $scope.getRooms();
  }
]);




