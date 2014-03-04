'use strict'

angular.module('dashboardApp')
  .controller 'ProspectsCtrl', [
    '$scope'
    'prospects'
    ($scope, prospects) ->
      $scope.getNumber = (num) -> [0...parseInt(num)]

      $scope.colOpts = globals.prospect.columns
      $scope.columns = globals.user.columns
      $scope.prospects = prospects

      statusCounts = _.chain(prospects)
        .countBy((prospect) ->
          switch prospect.status
            when "New"
              "New"
            when "Appointment Scheduled", "Contacted", "Contacted - Emailed", "Contacted - Texted", "Contacted - Voicemail", "Responsive - Search Setup"
              "Nuturing"
            when "Active Client", "Offer"
              "Active"
            when "Needs Follow-up"
              "Needs Follow-up"
            when "Under Contract"
              "Under Contract"
            when "Closed"
              "Closed"
            when "Disqualified - Financial", "Disqualified - Has Agent", "Invalid", "Non-responsive", "Not a good fit", "Not in my area", "Rental"
              "Dead"
        ).value()
      $scope.statuses = [
        ["Status", "Count"]
        ["New", (statusCounts['New'] or 0)]
        ["Nuturing", (statusCounts['Nuturing'] or 0)]
        ["Active", (statusCounts['Active'] or 0)]
        ["Needs Follow-up", (statusCounts['Needs Follow-up'] or 0)]
        ["Under Contract", (statusCounts['Under Contract'] or 0)]
        ["Closed", (statusCounts['Closed'] or 0)]
        ["Dead", (statusCounts['Dead'] or 0)]
      ]

      $scope.gridOpts =
        data: 'prospects'
        columnDefs: _.chain($scope.colOpts)
          .pick($scope.columns)
          .map((co) -> _.extend co, {visible: true})
          .value()
        enableColumnReordering: true
        enableColumnResize: true
        showColumnMenu: false #will re-enable when column selection is available
        showFilter: true
        showFooter: true
        showGroupPanel: false #will re-enable when ngGrid 2.0.8 is released
        sortInfo:
          fields: ['prospectLastActivity']
          directions: ['desc']
  ]