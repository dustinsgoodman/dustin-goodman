'use strict';

angular.module('dashboardApp')
  .directive 'userLayout', [->
    templateUrl: '/views/user-layout.html'
    restrict: 'A'
    transclude: true
    link: (scope, element, attrs) ->
  ]