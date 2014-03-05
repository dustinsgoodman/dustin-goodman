'use strict';

angular.module('dashboardApp')
  .directive 'zippy', [->
    template: '
      <div class="zippy panel panel-default">
        <div class="panel-heading" data-ng-click="toggleExpand()">
          <span class="h4 panel-title" data-ng-bind-html="summary"></span>
          <span class="collapse-arrow glyphicon" 
            data-ng-class="{\'glyphicon-chevron-right\': !isExpanded, \'glyphicon-chevron-down\': isExpanded}">
          </span>
        </div>
        <div class="panel-collapse collapse" data-ng-class="{\'in\': isExpanded}">
          <div class="panel-body" data-ng-transclude></div>
        </div>
      </div>
    '
    transclude: true
    restrict: 'EA'
    replace: true
    scope:
      summary: '@'
    link: (scope, element, attrs) ->
      scope.isExpanded = false
      scope.toggleExpand = ->
        scope.isExpanded = !scope.isExpanded
  ]
