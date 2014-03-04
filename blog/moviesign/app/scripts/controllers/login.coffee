'use strict'

angular.module('dashboardApp')
  .controller 'LoginCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    '$window'
    'Auth'
    ($rootScope, $scope, $location, $window, Auth) ->
      $scope.rememberme = false
      $rootScope.error = null
      $scope.login = ->
        $rootScope.error = null
        Auth.login {
          email: $scope.email
          password: $scope.password
          rememberme: $scope.rememberme
        }, ((res) ->
          $location.path '/'
        ), ((err) ->
          $rootScope.error = "Incorrect email/password. Please try again."
        )
      $scope.loginOauth = (provider) ->
        $window.location.href = "/auth/#{provider}"
  ]