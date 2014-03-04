'use strict'

angular.module('dashboardApp').directive('areaReport', [->
    templateUrl: '/views/feed-item/prospect-area-report-request-submitted.html'
    restrict: 'A'
    replace: true
    scope: true
    link: (scope, element, attrs) ->

        # reassign values from $parent
        scope = scope.$parent
        scope.item = scope.feedItem

        return
])