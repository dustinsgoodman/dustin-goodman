'use strict';

angular.module('dashboardApp')
  .directive 'sidebar', [->
    template: '
      <div class="sidebar" id="sidebar" 
        data-ng-class="{display:menuDisplay}">
        <!-- TODO: determine shortcuts -->
        <div class="sidebar-shortcuts hide" id="sidebar-shortcuts">
          <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
            <button class="btn btn-success">
              <i class="icon-signal"></i>
            </button>
            <button class="btn btn-info">
              <i class="icon-pencil"></i>
            </button>
            <button class="btn btn-warning">
              <i class="icon-group"></i>
            </button>
            <button class="btn btn-danger">
              <i class="icon-cogs"></i>
            </button>
          </div>
          <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
            <span class="btn btn-success"></span>
            <span class="btn btn-info"></span>
            <span class="btn btn-warning"></span>
            <span class="btn btn-danger"></span>
          </div>
        </div><!-- #sidebar-shortcuts -->

        <ul sidebar-nav links="links"></ul>
      </div>
    '
    restrict: 'EA'
    replace: true
    link: (scope, element, attrs) ->
      scope.menuDisplay = false

      sidebarCollapse = angular.element '
        <div class="sidebar-collapse" id="sidebar-collapse">
          <i class="icon-double-angle-left"></i>
        </div>
      '
      sidebarCollapse.bind 'click', ->
        icon = sidebarCollapse.find 'i'
        if element.hasClass 'menu-min'
          element.removeClass 'menu-min'
          icon.removeClass 'icon-double-angle-right'
          icon.addClass 'icon-double-angle-left'
        else
          element.addClass 'menu-min'
          icon.removeClass 'icon-double-angle-left'
          icon.addClass 'icon-double-angle-right'
        null
      element.append sidebarCollapse
  ]
