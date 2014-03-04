'use strict'

angular.module('dashboardApp').controller('MainCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    'Auth'
    ($rootScope, $scope, $location, Auth) ->
        # DOM Helpers
        $scope._ = _

        # App Utilities
        $scope.isLoggedIn = Auth.isLoggedIn()
        $scope.user = Auth.user
        $scope.logout = ->
            Auth.logout()
        $scope.links = [
            {access: permissions.accessLevels.agent, icon: 'dashboard', text: "My Dashboard", anchor: "/#/"}
            {access: permissions.accessLevels.agent, icon: 'list', text: "My Prospects", anchor: "/#/prospects"}
            {access: permissions.accessLevels.admin, icon: 'list', text: "Assignment", anchor: "/#/admin/assignment"}
        ]
        $scope.permissions = permissions
      
        $scope.$on '$routeChangeStart', (next, current) ->
            $scope.isLoggedIn = Auth.isLoggedIn()
])