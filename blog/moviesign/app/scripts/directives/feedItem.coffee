'use strict'

angular.module('dashboardApp').directive('feedItem', ['$compile', ($compile) ->
    template: "<div></div>"
    restrict: 'A'
    replace: true
    scope:
        feedItem: '=feedItem'
        view: '@view'
    link: (scope, element, attr) ->
        # helper functions for directives
        scope.testExist = (x) ->
            if x?
                if _.isArray(x)
                    if not _.isEmpty(x)
                        return true
                    else 
                        return false
                return true
            return false
        scope.testMin = (x) ->
            x? and not _.isNaN(parseInt(x)) and parseInt(x) isnt 0
        scope.testMax = (x) ->
            x? and not _.isNaN(parseInt(x)) and parseInt(x) isnt Math.pow(2,31)
        scope.toggleExpand = () ->
            scope.isExpanded = not scope.isExpanded
        scope.isExpanded = false

        # load new directive and make it reactive
        switch scope.feedItem.type
            when "prospect-property-viewed"
                element.html("<div property-view></div>")
            when "prospect-searched-properties"
                element.html("<div searched-properties></div>")
            when "prospect-property-inquiry-submitted"
                element.html("<div inquiry-submitted></div>")
            when "prospect-showing-request-submitted"
                element.html("<div showing-request></div>")
            when "prospect-area-report-request-submitted"
                element.html("<div area-report></div>")
            when "prospect-contact-form-submitted"
                element.html("<div contact-form></div>")
            # @TODO: add watch list and saved search handlers and views
            when "top-prospects"
                element.html("<div top-prospect></div>")
            when "hot-prospects"
                element.html("<div hot-prospect></div>")
        $compile(element.contents())(scope)

        return
])