'use strict'

angular.module('dashboardApp').directive('topProspect', [->
    templateUrl: '/views/feed-item/prospect-top-score.html'
    restrict: 'A'
    replace: true
    scope: true
    link: (scope, element, attrs) ->

        # reassign values from $parent
        scope = scope.$parent
        scope.prospect = scope.feedItem

        return

])