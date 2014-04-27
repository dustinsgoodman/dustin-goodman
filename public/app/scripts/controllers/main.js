'use strict';

angular.module('dustinGoodmanApp').controller('MainCtrl', [
  '$scope',
  'Auth',
  function ($scope, Auth) {
    $scope.copy = new Date().getFullYear();
    $scope.isNavCollapsed = true;
    $scope.isLoggedIn = Auth.isLoggedIn();

    $scope.logout = function () {
      Auth.logout();
    };
  }
]);