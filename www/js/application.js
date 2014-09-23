var app;

app = angular.module("starter", ["ionic", 'auth0']).run(function($ionicPlatform) {
  return $ionicPlatform.ready(function() {
    if (window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if (window.StatusBar) {
      return StatusBar.styleDefault();
    }
  });
}).config(function($stateProvider, $urlRouterProvider, $httpProvider, authProvider) {
  $stateProvider.state("main", {
    url: "/",
    templateUrl: "templates/main.html",
    controller: "UsersCtrl"
  });
  $stateProvider.state("dash", {
    url: "/dash",
    templateUrl: "templates/dash-index.html",
    controller: "DashCtrl"
  });
  $stateProvider.state("dash-host", {
    url: "/dash/host",
    templateUrl: "templates/dash-host.html",
    controller: "DashCtrl"
  }).state("signup", {
    url: "/signup",
    templateUrl: "templates/signup.html",
    controller: "UsersCtrl"
  }).state("signin", {
    url: "/signin",
    templateUrl: "templates/signin.html",
    controller: "UsersCtrl"
  }).state("users-index", {
    url: "/users",
    templateUrl: "templates/users-index.html",
    controller: "UsersCtrl"
  }).state("user-page", {
    url: "/users/:id",
    templateUrl: "templates/user-page.html",
    controller: "UsersCtrl"
  }).state("user-edit", {
    url: "/users/:id/edit",
    templateUrl: "templates/user-edit.html",
    controller: "UsersCtrl"
  }).state("circles-index", {
    url: "/circles",
    templateUrl: "templates/circles-index.html",
    controller: "CirclesCtrl"
  }).state('circle-page', {
    url: '/circle/:id',
    templateUrl: "templates/circle-page.html",
    controller: "CirclesCtrl"
  }).state('circle-new', {
    url: '/circle-new',
    templateUrl: "templates/circle-new.html",
    controller: "CirclesCtrl"
  });
  return $urlRouterProvider.otherwise("/");
});

app.controller("DashCtrl", ["$scope", "$http", '$stateParams', '$state', function($scope, $http, $stateParams, $state) {}]);

app.controller("CirclesCtrl", [
  "$scope", "$http", "$stateParams", function($scope, $http, $stateParams) {
    console.log("Hello");
    $scope.circles = [];
    $scope.circle = {};
    $scope.getCircles = function() {
      return $http.get("http://localhost:3000/rooms.json").success(function(data) {
        $scope.circles = data;
        return console.log(data);
      });
    };
    $scope.createCircle = function() {
      var conf;
      console.log({
        room: $scope.circle
      });
      conf = confirm("Are you sure?");
      if (conf) {
        return $http.post("http://localhost:3000/rooms.json", {
          room: $scope.circle
        }).success(function(data) {
          $scope.circles.push(data);
          return console.log(data);
        }).error(function(errs) {
          $scope.errors = errs["errors"];
          return console.log($scope.errors);
        });
      }
    };
    $scope.showCircle = function() {
      return $http.get("http://localhost:3000/rooms/" + $stateParams.id + ".json").success(function(data) {
        return $scope.circle = data;
      });
    };
    $scope.circleInfo = function() {
      return $http.get("http://localhost:3000/rooms/" + $stateParams.id + "/users.json").success(function(data) {
        $scope.circleInfo = data;
        return console.log(data);
      });
    };
    $scope.getCircles();
    $scope.showCircle();
    return $scope.circleInfo();
  }
]);

app.controller("UsersCtrl", [
  "$scope", "$http", '$stateParams', '$state', function($scope, $http, $stateParams, $state) {
    $scope.users = [];
    $scope.newUser = {};
    $scope.user = {};
    $scope.getUsers = function() {
      return $http.get("http://localhost:3000/users.json").success(function(data) {
        return $scope.users = data;
      });
    };
    $scope.createUser = function() {
      console.log({
        user: $scope.newUser
      });
      return $http.post("http://localhost:3000/users.json", {
        user: $scope.newUser
      }).success(function(data) {
        console.log(data);
        $scope.users.push(data);
        $scope.newUser = {};
        return $state.go('signin');
      }).error(function(errs) {
        $scope.errors = errs["errors"];
        return console.log($scope.errors);
      });
    };
    $scope.showUser = function() {
      return $http.get("http://localhost:3000/users/" + $stateParams.id + ".json").success(function(data) {
        return $scope.user = data;
      });
    };
    $scope.editUser = function(user) {
      return $http.put("http://localhost:3000/users/" + user.id + ".json", user).success(function(data) {
        return console.log(data);
      });
    };
    $scope.showUser();
    return $scope.getUsers();
  }
]);




