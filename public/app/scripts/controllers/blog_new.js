'use strict';

angular.module('dustinGoodmanApp').controller('BlogNewCtrl', ['$scope', 'newPost', function ($scope, newPost) {
  $scope.newPost = newPost;
}]);