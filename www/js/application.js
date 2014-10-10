var app;

app = angular.module("starter", ["ionic", 'auth0', 'UserFactories', 'CircleFactories', "TabFactories"]).run(function($ionicPlatform) {
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
  }).state('menu', {
    url: "/menu",
    templateUrl: "templates/menu.html",
    controller: 'DashCtrl'
  }).state("dash", {
    url: "/user/dash",
    name: 'dash',
    templateUrl: "templates/dash-index.html",
    controller: "DashCtrl"
  }).state("dash-home", {
    url: "/user/home",
    name: 'dash-home',
    templateUrl: "templates/dash-home.html",
    controller: "DashCtrl"
  }).state("signup", {
    url: "/signup",
    templateUrl: "templates/signup.html",
    controller: "UsersCtrl"
  }).state("signin", {
    url: "/signin",
    templateUrl: "templates/signin.html",
    controller: "SessionsCtrl"
  }).state("user-index", {
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
    url: "/circles",
    templateUrl: "templates/circles-index.html",
    controller: "CirclesCtrl"
  }).state('circle-page', {
    url: '/circle/:circle_id/user/:user_id',
    templateUrl: "templates/circle-page.html",
    controller: "CirclesCtrl"
  }).state('circle-new', {
    url: '/circle-new',
    templateUrl: "templates/circle-new.html",
    controller: "CirclesCtrl"
  });
  return $urlRouterProvider.otherwise("/");
});

app.controller("CirclesCtrl", [
  "$scope", "$http", "$stateParams", '$state', '$rootScope', 'Circle', function($scope, $http, $stateParams, $state, $rootScope, Circle) {
    $scope.circles = [];
    $scope.circle = {};
    $scope.getCircles = function() {
      return Circle.all().success(function(data) {
        return $scope.circles = data;
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
        return $http.post("http://localhost:3000/user/" + $rootScope.current_user.id + "/rooms.json", {
          room: $scope.circle
        }).success(function(data) {
          $scope.circles.push(data);
          return $state.go('circle-page', {
            user_id: $stateParams.user_id,
            circle_id: data.id
          });
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
      return Circle.info($stateParams.circle_id).success(function(data) {
        var item, _i, _len, _ref, _results;
        console.log("Circle Info", data);
        $scope.circleInfo = data;
        _ref = data['users'];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          if ($rootScope.current_user.id === item.id) {
            _results.push($scope.joinShow = false);
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      });
    };
    $scope.joinCircle = function() {
      return $http.post("http://localhost:3000/rooms/" + $stateParams.circle_id + "/users/" + $rootScope.current_user.id + ".json").success(function(joinData) {
        return console.log("After post");
      });
    };
    $scope.userGo = function() {
      console.log("Hello");
      return $state.go('user-index');
    };
    $scope.getCircles();
    $scope.showCircle();
    return $scope.circleInfo();
  }
]);

app.controller("DashCtrl", [
  "$scope", "$http", '$stateParams', '$state', '$rootScope', function($scope, $http, $stateParams, $state, $rootScope) {
    console.log("STARTING TWO");
    $scope.getCurrentRooms = function() {
      return $scope.$watch("current_user", function() {
        return $http.get("http://localhost:3000/user/" + $scope.current_user.id + "/dash.json").success(function(data) {
          console.log("UserRoom", data);
          return $scope.current_room = data;
        });
      });
    };
    $scope.userGo = function() {
      console.log("Hello");
      return $state.go('circle-new');
    };
    $scope.circleGo = function() {
      console.log("Hello");
      return $state.go('circles-index');
    };
    return $scope.getCurrentRooms();
  }
]);

app.controller("MainCtrl", [
  "$scope", "$http", "$rootScope", '$ionicModal', function($scope, $http, $rootScope, $ionicModal) {
    console.log("STARTIN");
    if (!$scope.current_user) {
      console.log("Checking for current user");
      $http.get("http://localhost:3000/logged_in_user.json").success((function(_this) {
        return function(user) {
          console.log("Welcome, ", user);
          return $rootScope.current_user = user;
        };
      })(this));
    }
    return $ionicModal.fromTemplateUrl('templates/modal.html', {
      scope: $scope,
      animation: 'slide-in-up'
    }).then(function(modal) {
      $scope.modal = modal;
      $scope.closeModal = function() {
        console.log("Hello Hello");
        console.log($scope.modal);
        return $scope.modal.hide();
      };
      $scope.hello = function() {
        return alert("Hello");
      };
      $scope.openModal = function() {
        console.log($scope.modal);
        return $scope.modal.show();
      };
      $scope.$on('$destroy', function() {
        return $scope.modal.remove();
      });
      $scope.$on('modal.hidden', function() {});
      return $scope.$on(modal.removed, function() {});
    });
  }
]);

app.controller("SessionsCtrl", [
  "$scope", "$http", "$rootScope", "$location", '$state', function($scope, $http, $rootScope, $location, $state) {
    return $scope.addSession = function(loginUser) {
      return $http.post("http://localhost:3000/login.json", {
        user: loginUser
      }).success((function(_this) {
        return function(user) {
          $rootScope.current_user = user;
          return $state.go('dash');
        };
      })(this)).error((function(_this) {
        return function(errors) {
          return alert("Invalid email or password");
        };
      })(this));
    };
  }
]);

app.controller("UsersCtrl", [
  "$scope", "$http", '$stateParams', '$state', '$location', '$rootScope', 'User', function($scope, $http, $stateParams, $state, $location, $rootScope, User) {
    console.log("Initialized UsersCtrl");
    console.log($rootScope);
    $scope.users = [];
    $scope.newUser = {};
    $scope.user = {};
    $scope.current_user = $rootScope.current_user;
    $scope.getUsers = function() {
      return User.all().success(function(data) {
        return $scope.users = data;
      });
    };
    $scope.createUser = function() {
      console.log("Running!");
      console.log($scope.newUser);
      return User.post($scope.newUser).success(function(data) {
        console.log(data);
        $scope.users.push(data);
        $scope.newUser = {};
        $rootScope.current_user = data;
        return $state.go('user-edit', {
          user_id: $rootScope.current_user.id
        });
      }).error(function(errs) {
        $scope.errors = errs["errors"];
        return console.log($scope.errors);
      });
    };
    $scope.showUser = function() {
      return User.show($stateParams.user_id).success(function(data) {
        $scope.user = data;
        if ($scope.current_user.id === data.id) {
          return $scope.show = true;
        }
      });
    };
    $scope.editUser = function(user) {
      $http.put("http://localhost:3000/users/" + $stateParams.user_id + ".json", {
        user: user
      }).success(function(data) {
        console.log(data);
        return $state.go('user-page', {
          user_id: $stateParams.user_id
        });
      });
      return $scope.userGo = function() {
        console.log("Hello");
        return $state.go('user-index');
      };
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
      show: function(id) {
        return $http.get("http://localhost:3000/rooms/" + id + ".json");
      },
      info: function(id) {
        return $http.get("http://localhost:3000/rooms/" + id + "/users.json");
      }
    };
  }
]);

var TabFactories;

TabFactories = angular.module("TabFactories", []);

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
      }
    };
  }
]);
