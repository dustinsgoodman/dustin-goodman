'use strict';

angular.module('dashboardApp')
  .directive 'piechart', [->
    template: '<div></div>'
    restrict: 'EA'
    replace: true
    scope:
      title: '@'
      data: '='
    link: (scope, element, attrs) ->
      data = google.visualization.arrayToDataTable(
        [[scope.title, "Number of #{scope.title}"]].concat(
          _.map(scope.data, (v,k) -> [k, v])))
      opts =
        title: scope.title
        chartArea:
          top: 20
        legend:
          position: 'none'
      chart = new google.visualization.PieChart element[0]
      chart.draw data, opts
  ]
