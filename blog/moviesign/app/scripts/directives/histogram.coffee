'use strict';

angular.module('dashboardApp')
  .directive 'histogram', [->
    template: '<div></div>'
    restrict: 'EA'
    replace: true
    scope:
      title: '@'
      data: '='
    link: (scope, element, attrs) ->
      data = google.visualization.arrayToDataTable scope.data
      opts =
        bar:
          groupWidth: "90%"
        legend:
          position: "none"
        title: "#{scope.title} Distribution"
        tooltip:
          trigger: "none"
        vAxis:
          format: "#,###"
        
      chart = new google.visualization.Histogram element[0]
      chart.draw data, opts
  ]