'use strict';

angular.module('dustinGoodmanApp').controller('RegisterCtrl', [
  '$scope',
  '$rootScope',
  '$location',
  'Auth',
  'newUser',
  function ($scope, $rootScope, $location, Auth, newUser) {
    $scope.user = newUser;

    $scope.register = function () {
      Auth.register({
        user: $scope.user
      }, function () {
        $location.path('/');
      }, function (err) {
        $rootScope.error = err;
      });
    };
	}
]);