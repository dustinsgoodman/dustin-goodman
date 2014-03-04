'use strict';

angular.module('dashboardApp')
  .directive 'sidebarNav', [
    '$location'
    ($location) ->
      template: "
        <ul class='nav nav-list'>
          <li data-ng-repeat='link in links' 
            data-ng-class='{active: link.active}'
            data-access-level='{{link.access}}'>
            <a href='{{link.anchor}}'>
              <i class='icon-{{link.icon}}'></i>
              <span class='menu-text'>{{link.text}}</span>
            </a>
          </li>
        </ul>
      "
      restrict: 'EA'
      replace: true
      scope:
        links: '='
      link: (scope, element, attrs) ->
        scope.location = $location
        scope.$watch 'location.path()', ->
          last = _.find scope.links, (link) -> 
            link.active
          last.active = false if last?

          next = _.find scope.links, (link) ->
            "/##{$location.path()}" is link.anchor
          next.active = true if next?
  ]