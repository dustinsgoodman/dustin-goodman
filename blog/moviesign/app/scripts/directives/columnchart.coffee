'use strict'

angular.module('dashboardApp')
  .directive 'columnchart', [->
    template: '<div></div>'
    restrict: 'EA'
    replace: true
    scope:
      title: '@'
      data: '='
    link: (scope, element, attrs) ->
      data = google.visualization.arrayToDataTable(scope.data)
      opts =
        hAxis:
          format: "#,###"
        legend:
          position: 'none'
        title: scope.title
      chart = new google.visualization.ColumnChart element[0]
      chart.draw data, opts
  ]
