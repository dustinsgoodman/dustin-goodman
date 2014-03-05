'use strict'

angular.module('dashboardApp')
  .filter 'nullDate', ['$filter', ($filter) ->
    standardDateFilter = $filter('date')
    (input) ->
      if input? and input is 0
        ''
      else if input? and input isnt 0
        standardDateFilter(input, 'medium') 
      else 
        ''
  ]
