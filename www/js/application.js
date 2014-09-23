var app;

app = angular.module("starter", ["ionic", 'auth0', 'UserFactories', 'CircleFactories']).run(function($ionicPlatform) {
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
  }).state("dash", {
    url: "/user/:user_id/dash",
    name: 'dash',
    templateUrl: "templates/dash-index.html",
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
    url: "/user-index",
    templateUrl: "templates/users-index.html",
    controller: "UsersCtrl"
  }).state("user-page", {
    url: "/user/:user_id",
    templateUrl: "templates/user-page.html",
    controller: "UsersCtrl"
  }).state("user-edit", {
    url: "/user/:user_id/edit",
    templateUrl: "templates/user-edit.html",
    controller: "UsersCtrl"
  }).state("circles-index", {
    url: "/user/:user_id/circles",
    templateUrl: "templates/circles-index.html",
    controller: "CirclesCtrl"
  }).state('circle-page', {
    url: '/user/:user_id/circle/:circle_id',
    templateUrl: "templates/circle-page.html",
    controller: "CirclesCtrl"
  }).state('circle-new', {
    url: '/user/:user_id/circle-new',
    templateUrl: "templates/circle-new.html",
    controller: "CirclesCtrl"
  });
  return $urlRouterProvider.otherwise("/");
});

app.controller("CirclesCtrl", [
  "$scope", "$http", "$stateParams", '$state', 'Circle', function($scope, $http, $stateParams, $state, Circle) {
    console.log("Hello");
    $scope.circles = [];
    $scope.circle = {};
    $scope.getCircles = function() {
      return Circle.all().success(function(data) {
        $scope.circles = data;
        return console.log(data);
      });
    };
    $scope.createCircle = function() {
      var conf;
      console.log("hello");
      console.log({
        room: $scope.circle
      });
      conf = confirm("Are you sure?");
      if (conf) {
        return $http.post("http://localhost:3000/user/" + $stateParams.user_id + "/rooms.json", {
          room: $scope.circle
        }).success(function(data) {
          $scope.circles.push(data);
          return console.log("Data ", data);
        }).error(function(errs) {
          $scope.errors = errs["errors"];
          return console.log($scope.errors);
        });
      }
    };
    $scope.showCircle = function() {
      return Circle.show($stateParams.circle_id).success(function(data) {
        return $scope.circle = data;
      });
    };
    $scope.circleInfo = function() {
      return $http.get("http://localhost:3000/rooms/" + $stateParams.circle_id + "/users.json").success(function(data) {
        $scope.circleInfo = data;
        return console.log(data);
      });
    };
    $scope.getCircles();
    $scope.showCircle();
    return $scope.circleInfo();
  }
]);

app.controller("DashCtrl", ["$scope", "$http", '$stateParams', '$state', function($scope, $http, $stateParams, $state) {}]);

app.controller("UsersCtrl", [
  "$scope", "$http", '$stateParams', '$state', '$location', 'User', function($scope, $http, $stateParams, $state, $location, User) {
    $scope.users = [];
    $scope.newUser = {};
    $scope.user = {};
    $scope.getUsers = function() {
      return User.all().success(function(data) {
        return $scope.users = data;
      });
    };
    $scope.createUser = function() {
      return User.post($scope.newUser).success(function(data) {
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
      return User.show($stateParams.user_id).success(function(data) {
        return $scope.user = data;
      });
    };
    $scope.editUser = function(user) {
      return User.edit(user).success(function(data) {
        console.log(data);
        return $state.go('user-page', {
          user_id: user.id
        });
      });
    };
    $scope.showUser();
    return $scope.getUsers();
  }
]);

var CircleFactories;

CircleFactories = angular.module("CircleFactories", []);

CircleFactories.factory('Circle', [
  '$http', function($http) {
    return {
      all: function() {
        return $http.get("http://localhost:3000/rooms.json").success(function(data) {
          return console.log(data);
        });
      },
      post: function(newCircle) {
        return $http.post("http://localhost:3000/rooms.json", {
          room: newCircle
        });
      },
      show: function(id) {
        return $http.get("http://localhost:3000/rooms/" + id + ".json");
      },
      info: function(id) {
        $http.get("http://localhost:3000/rooms/" + id + "/users.json");
        return console.log(data);
      }
    };
  }
]);

var UserFactories;

UserFactories = angular.module("UserFactories", []);

UserFactories.factory('User', [
  '$http', function($http) {
    return {
      all: function() {
        return $http.get("http://localhost:3000/users.json").success(function(data) {
          return console.log(data);
        });
      },
      post: function(newUser) {
        return $http.post("http://localhost:3000/users.json", {
          user: newUser
        });
      },
      show: function(id) {
        return $http.get("http://localhost:3000/users/" + id + ".json");
      },
      edit: function(user) {
        return $http.put("http://localhost:3000/users/" + user.id + ".json", user);
      }
    };
  }
]);
