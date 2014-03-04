'use strict'

angular.module('dashboardApp').filter('checkmark', [() ->
    (input) ->
        if _.isEmpty(input) 
            return '\u2718'
        else 
            return '\u2713'
])