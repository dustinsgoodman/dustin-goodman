'use strict'

angular.module('dashboardApp').directive('propertyView', [->
    templateUrl: '/views/feed-item/prospect-property-viewed.html'
    restrict: 'A'
    replace: true
    scope: true
    link: (scope, element, attrs) ->

        # reassign values from $parent
        scope = scope.$parent
        scope.prospect = scope.feedItem.prospectInfo
        scope.property = scope.feedItem.propertyInfo
        scope.count = scope.feedItem.count
        scope.time = scope.feedItem.time

        return
])