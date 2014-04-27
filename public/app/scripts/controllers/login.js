'use strict';

angular.module('dustinGoodmanApp').controller('LoginCtrl', [
  '$scope',
  'Auth',
  function ($scope, Auth) {
    $scope.user = {email: '', password: ''};

    $scope.login = function () {
      Auth.login($scope.user);
    };
  }
]);