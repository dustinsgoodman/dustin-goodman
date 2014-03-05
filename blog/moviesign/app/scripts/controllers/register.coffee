'use strict'

angular.module('dashboardApp')
  .controller 'RegisterCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    'Auth'
    ($rootScope, $scope, $location, Auth) ->
      $scope.role = Auth.userRoles.user
      $scope.userRoles = Auth.userRoles
      $scope.register = ->
        Auth.register {
          username: $scope.username
          password: $scope.password
          role: $scope.role
        }, (->
          $location.path '/#'
        ), ((err) ->
          $rootScope.error = err
        )
  ]