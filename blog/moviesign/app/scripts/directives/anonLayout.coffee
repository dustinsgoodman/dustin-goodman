'use strict';

angular.module('dashboardApp')
  .directive 'anonLayout', [->
    templateUrl: '/views/anon-layout.html'
    restrict: 'A'
    replace: true
    transclude: true
    link: (scope, element, attrs) ->
  ]       