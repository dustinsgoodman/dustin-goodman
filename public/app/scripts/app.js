'use strict';

var app = angular.module('dustinGoodmanApp', [
  'ngCookies',
  'ngResource',
  'ngRoute',
  'ngSanitize',
  'ui.bootstrap'
]);

app.config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  }]);
