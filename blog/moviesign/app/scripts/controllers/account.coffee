'use strict'

angular.module('dashboardApp')
  .controller 'AccountCtrl', [
  	'$scope'
  	'Auth'
  	($scope, Auth) ->
  	  $scope.user = Auth.user
  ]