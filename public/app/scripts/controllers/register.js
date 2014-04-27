'use strict';

angular.module('dustinGoodmanApp').controller('RegisterCtrl', [
  '$scope',
  'Auth',
  'newUser',
  function ($scope, Auth, newUser) {
    $scope.user = newUser;

    $scope.register = function () {
      Auth.register($scope.user);
    };
	}
]);