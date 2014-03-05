'use strict';

angular.module('dashboardApp')
  .directive 'accessLevel', [
    'Auth'
    (Auth) ->
      restrict: 'A'
      link: (scope, element, attrs) ->
        updateCSS = ->
          if userRole and accessLevel
            if not Auth.authorize accessLevel, userRole
              element.css 'display', 'none'
            else
              element.css 'display', prevDisp

        prevDisp = element.css('display')
        userRole = accessLevel = undefined

        scope.user = Auth.user
        scope.$watch 'user', ((user) ->
          userRole = user.role if user.role
          updateCSS()
        ), true

        attrs.$observe 'accessLevel', (al) ->
          accessLevel = scope.$eval al if al
          updateCSS()
  ]
