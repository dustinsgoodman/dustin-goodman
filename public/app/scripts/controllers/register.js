'use strict';

angular.module('dustinGoodmanApp').controller('RegisterCtrl', ['$scope', 'newUser', function ($scope, newUser) {
	$scope.user = newUser;
	
}]);