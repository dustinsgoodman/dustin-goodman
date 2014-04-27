'use strict';

var app = angular.module('dustinGoodmanApp', [
  'ngCookies',
  'ngResource',
  'ngRoute',
  'ngSanitize',
  'restangular',
  'ui.bootstrap'
]);

app.config([
  '$routeProvider',
  '$locationProvider',
  '$httpProvider',
  'RestangularProvider',
  'permissions',
  function ($routeProvider, $locationProvider, $httpProvider, RestangularProvider, permissions) {
    var access;

    RestangularProvider.setBaseUrl('/api');
    RestangularProvider.setFullResponse(true);

    access = permissions.accessLevels;
    $routeProvider
      .when('/', {
        access: access.public,
        controller: 'HomeCtrl',
        templateUrl: '/views/home.html',
      })
      .when('/register', {
        access: access.anon,
        controller: 'RegisterCtrl',
        templateUrl: '/views/register.html',
        resolve: {
          newUser: ['User', function (User) {
            return User.signup();
          }]
        }
      })
      .when('/login', {
        access: access.anon,
        controller: 'LoginCtrl',
        templateUrl: '/views/login.html'
      })
      .when('/blog', {
        access: access.public,
        controller: 'BlogCtrl',
        templateUrl: 'views/blog/index.html',
        resolve: {
          posts: ['Restangular', function (Restangular) {
            Restangular.all('blog_posts').getList().then(function (resp) {
              return resp.data;
            });
          }]
        }
      })
      .when('/blog/new', {
        access: access.admin,
        controller: 'BlogNewCtrl',
        templateUrl: 'views/blog/new.html',
        resolve: {
          newPost: ['Restangular', function (Restangular) {
            Restangular.all('blog_posts').one('new').get().then(function (resp) {
              window.post = resp.data;
              return resp.data;
            });
          }]
        }
      })
      .otherwise({
        redirectTo: '/'
      });

    // $locationProvider.html5mode(true);

    $httpProvider.interceptors.push([
      '$location',
      '$q',
      function ($location, $q) {
        return {
          response: function (response) {
            return response;
          },
          responseError: function (response) {
            switch (response.status) {
              case 401:
                $location.path('/login');
                break;
              case 403:
                $location.path('/');
                break;
              case 404:
                $location.path('/404');
                break;
              case 422:
                break;
              case 500:
                $location.path('/500');
                break;
              default:
                console.log('unknown handler', response);
                $location.path('/500');
                break;
            }
            return $q.reject(response);
          }
        };
      }
    ]);
  }
]);

app.run([
  '$rootScope',
  '$location',
  'Auth',
  function ($rootScope, $location, Auth) {
    $rootScope.$on('$routeChangeStart', function (event, next, current) {
      $rootScope.errors = null;
      if (_.isUndefined(next.access)) { next.access = 0; }
      if (!Auth.authorize(next.access)) {
        if (Auth.isLoggedIn()) {
          $location.path('/');
        } else {
          $location.path('/login');
        }
      }
    });
  }
]);