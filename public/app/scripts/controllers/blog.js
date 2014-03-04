'use strict';

angular.module('dustinGoodmanApp').controller('BlogCtrl', ['$scope', 'posts', function ($scope, posts) {
  $scope.posts = posts;
}]);