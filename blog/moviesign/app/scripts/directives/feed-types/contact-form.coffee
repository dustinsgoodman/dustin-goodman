'use strict'

angular.module('dashboardApp').directive('contactForm', [->
    templateUrl: '/views/feed-item/prospect-contact-form-submitted.html'
    restrict: 'A'
    replace: true
    scope: true
    link: (scope, element, attrs) ->

        # reassign values from $parent
        scope = scope.$parent
        scope.item = scope.feedItem

        return
])