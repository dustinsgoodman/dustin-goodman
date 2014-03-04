'use strict';

angular.module('dashboardApp')
  .directive 'widget', [->
    template: '
      <div class="widget-box">
        <div class="widget-header">
          <h5>{{title}}</h5>
          <div class="widget-toolbar">
            <a data-ng-click="settings()" data-action="settings" data-ng-show="showSettings"><i class="icon-cog"></i></a>
            <a data-ng-click="reload()" data-action="reload" data-ng-show="showReload"><i class="icon-refresh"></i></a>
            <a data-ng-click="collapse()" data-action="collapse" data-ng-show="showCollapse"><i class="icon-chevron-up"></i></a>
            <a data-ng-click="close()" data-action="close" data-ng-show="showClose"><i class="icon-remove"></i></a>
          </div>
        </div>
        <div class="widget-body" data-infinite-scroll="infiniteScrollCallback()" 
            data-infinite-scroll-distance="2" infinite-scroll-disabled="{{!infiniteScrollCallback}}">
          <div class="widget-main no-padding" data-ng-transclude></div>
        </div>
      </div>
    '
    transclude: true
    restrict: 'EA'
    replace: true
    scope:
      title: '@'
      settingsCallback: '&'
      reloadCallback: '&'
      collapseCallback: '&'
      closeCallback: '&'
      infiniteScrollCallback: '&'
    link: (scope, element, attrs) ->
      scope.showClose = attrs.closeCallback
      scope.showSettings = attrs.settingsCallback
      scope.showReload = attrs.reloadCallback
      scope.showCollapse = attrs.collapseCallback
      scope.collapse = ->
        #todo
      scope.close = ->
        element.parent().hide(300)
        scope.closeCallback()
      scope.reload = (handler) ->
        #todo
      scope.settings = ->
        #todo
  ]
