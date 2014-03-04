'use strict'

angular.module('dashboardApp').directive('inquirySubmitted', [->
    templateUrl: '/views/feed-item/prospect-property-inquiry-submitted.html'
    restrict: 'A'
    replace: true
    scope: true
    link: (scope, element, attrs) ->

        # reassign values from $parent
        scope = scope.$parent
        scope.item = scope.feedItem

        return
])